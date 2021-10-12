import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/addCommunityPost.dart';
import 'package:mumbi_app/View/postComment_view.dart';
import 'package:mumbi_app/ViewModel/community_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/reaction_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customGridLayoutPhoto.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:signalr_core/signalr_core.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int currentPos = 0;
  CommunityViewModel _communityViewModel;
  MomViewModel _momViewModel;
  int imageWidth = 0;
  int imageHeight = 0;
  final serverURL = "https://mumbi.xyz/api/commentHub";
  HubConnection hubConnection;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _communityViewModel = CommunityViewModel.getInstance();
    _communityViewModel.getCommunityPost();

    _momViewModel = MomViewModel.getInstance();
    initSignalR();
  }

  void initSignalR() async {
    final hubConnection = new HubConnectionBuilder()
        .withUrl(
            serverURL,
            HttpConnectionOptions(
              transport: HttpTransportType.webSockets,
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              logging: (level, message) => print(message),
            ))
        .withAutomaticReconnect()
        .build();

    hubConnection.onclose((exception) {
      print("SignalR lost connection: " + exception.toString());
    });

    hubConnection.on(
        "BroadcastComment",
        (data) => {
              print("SignalR: " + data[0]['fullName'].toString()),
              print("SignalR: " + data[0]['avatar'].toString()),
              print("SignalR: " + data[1]['commentId'].toString()),
              print("SignalR: " + data[1]['commentContent'].toString()),
              print(
                  "SignalR: " + data[1]['createdTime'].toString()) //comment nha
            });

    /*
          Tạo 1 method getUserInfo và getMessage xong gán model vào mấy cái data đó
          đặt method ở hubConnection.on, mỗi khi có comment nó sẽ load lại
    */
    await hubConnection
        .start()
        .then((value) => {print('SignalR Connected!')})
        .catchError((e) => {
              print('Error while establishing SignalR Connection: ' +
                  e.toString())
            });
  }

  void _onRefresh() async {
    await _communityViewModel.postListModel.clear();
    setState(() {});
    await _communityViewModel.getCommunityPost();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _communityViewModel.getMoreCommunityPost();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: LIGHT_GREY_COLOR,
        appBar: AppBar(
          title: Text("Cộng đồng"),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if(mode == LoadStatus.loading){
                body =  loadingProgress();
              } else {
                body = Text(NO_MORE_POST_MESSAGE);
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: listCommunityPost(),
        ));
  }

  Widget listCommunityPost() {
    return ScopedModel(
      model: _communityViewModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, CommunityViewModel model) {
          return model.postListModel == null
              ? loadingProgress()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PostBar(),
                    for (var model in model.postListModel) CommunityPost(model),
                  ],
                );
        },
      ),
    );
  }

  Widget CommunityPost(PostModel postModel) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            UserInfo(postModel),
            PostContent(postModel.postContent),
            if (postModel.imageURL != null && postModel.imageURL != "")
              CustomGridLayoutPhoto(postModel.imageURL),
            PostInteraction(postModel),
          ],
        ),
      ),
    );
  }

  Widget PostBar() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: ListTile(
        leading: _momViewModel.momModel == null
            ? CircleAvatar(radius: 22, backgroundColor: LIGHT_GREY_COLOR)
            : CircleAvatar(
                radius: 22,
                backgroundColor: LIGHT_GREY_COLOR,
                backgroundImage:
                    CachedNetworkImageProvider(_momViewModel.momModel.imageURL),
              ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCommunityPost(),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: GREY_COLOR),
            ),
            width: SizeConfig.safeBlockHorizontal * 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Text(
                "Hôm nay bạn thế nào?",
                style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget UserInfo(PostModel postModel) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(postModel.avatar),
      ),
      title: Text(
        postModel.fullName,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      subtitle: Text(DateTimeConvert.timeAgoSinceDate(postModel.approvedTime)),
      trailing: _momViewModel == null
          ? SizedBox.shrink()
          : postModel.userId == _momViewModel.momModel.id
              ? PopupMenuButton<String>(
                  onSelected: (value) async {
                    switch (value) {
                      case 'Xóa bài viết':
                        showConfirmDialog(context, "Xóa",
                            "Bạn có muốn xóa bài viết này?",
                            ContinueFunction: () async {
                          Navigator.pop(context);
                          showProgressDialogue(context);
                          bool result = false;
                          result = await CommunityViewModel().deleteCommunityPost(postModel);
                          if(result){
                            _communityViewModel.postListModel.remove(postModel);
                            setState(() {});
                          }
                          Navigator.pop(context);
                          showResult(context, result,
                              "Bài viết đã được xóa khỏi cộng đồng");
                          setState(() {});
                        });
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Xóa bài viết'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },icon: Icon(Icons.more_horiz),
                )
              : SizedBox.shrink(),
    );
  }

  Widget PostContent(String content) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: ReadMoreText(
          content,
          trimLength: 250,
          colorClickableText: BLACK_COLOR,
          delimiter: "",
          trimCollapsedText: '... Xem thêm',
          trimExpandedText: ' Thu gọn',
          moreStyle: TextStyle(fontWeight: FontWeight.w600),
          lessStyle: TextStyle(fontWeight: FontWeight.w600),
          style: TextStyle(color: BLACK_COLOR, fontSize: 16),
        ),
      ),
    );
  }

  Widget PostInteraction(PostModel postModel) {
    return Column(
      children: [
        Row(
          children: [
            InteractiveButton(
                Icons.thumb_up_off_alt_outlined, "Thích", postModel),
            InteractiveButton(Icons.comment_outlined, "Bình luận", postModel),
          ],
        ),
      ],
    );
  }

  Widget InteractiveButton(IconData icon, String action, PostModel postModel) {
    return Material(
      color: WHITE_COLOR,
      child: InkWell(
        onTap: () async {
          if (action == "Thích") {
            showProgressDialogue(context);
            if (postModel.idReaction != 0) {
              await ReactionViewModel().deleteReaction(postModel.idReaction);
              await ReactionViewModel().checkPostReaction(postModel);
              postModel.totalReaction--;
            } else {
              await ReactionViewModel().addPostReaction(postModel.id);
              await ReactionViewModel().checkPostReaction(postModel);
              postModel.totalReaction++;
            }
            Navigator.pop(context);
          } else if (action == "Bình luận") {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostComment(postModel),
                ));
          }
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: action == "Thích"
                    ? postModel.idReaction != 0
                        ? PINK_COLOR
                        : LIGHT_DARK_GREY_COLOR.withOpacity(0.6)
                    : LIGHT_DARK_GREY_COLOR.withOpacity(0.6),
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "${count(action, postModel)}",
                style: TextStyle(
                    color: action == "Thích"
                        ? postModel.idReaction != 0
                            ? PINK_COLOR
                            : LIGHT_DARK_GREY_COLOR.withOpacity(0.6)
                        : LIGHT_DARK_GREY_COLOR.withOpacity(0.6),
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  num count(String action, PostModel postModel) {
    if (action == "Thích") {
      return postModel.totalReaction == null ? 0 : postModel.totalReaction;
    } else if (action == "Bình luận") {
      return postModel.totalComment == null ? 0 : postModel.totalComment;
    } else {
      return 0;
    }
  }
}
