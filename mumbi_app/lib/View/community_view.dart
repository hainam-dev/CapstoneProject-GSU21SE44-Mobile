import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/addCommunityPost.dart';
import 'package:mumbi_app/ViewModel/communityPost_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/reaction_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:readmore/readmore.dart';
import 'package:scoped_model/scoped_model.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int currentPos = 0;
  List<String> getImages;

  CommunityViewModel _communityViewModel;
  ReactionViewModel _reactionViewModel;
  MomViewModel _momViewModel;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _communityViewModel = CommunityViewModel.getInstance();
    _communityViewModel.getCommunityPost();
    _reactionViewModel = new ReactionViewModel();
    _momViewModel = MomViewModel.getInstance();

    if (getImages != null && getImages != "")
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getImages.forEach((url) {
          precacheImage(NetworkImage(url), context);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHT_GREY_COLOR,
      appBar: AppBar(
        title: Text("Cộng đồng"),
      ),
      body: Column(
        children: [
          PostBar(),
          listCommunityPost(),
        ],
      ),
    );
  }

  Widget listCommunityPost() {
    return ScopedModel(
      model: _communityViewModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, CommunityViewModel model) {
          return model.postListModel == null
              ? loadingProgress()
              : Expanded(
                child: ListView.builder(
                  itemCount: model.postListModel.length,
                  itemBuilder: (context, index) {
                    PostModel postModel = model.postListModel[index];
                    return CommunityPost(postModel);
                  },
                ),
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
              getPostImage(postModel.imageURL),
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
                "Hôm nay bạn có gì?",
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
      trailing: postModel.userId == _momViewModel.momModel.id
          ? PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'Xóa bài viết':
                    showConfirmDialog(context, "Xóa bài viết",
                        "Bạn có muốn xóa bài viết này?",
                        ContinueFunction: () async {
                      Navigator.pop(context);
                      showProgressDialogue(context);
                      bool result = false;
                      result = await CommunityViewModel()
                          .deleteCommunityPost(postModel.id);
                      CommunityViewModel().getCommunityPost();
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
              },
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
          style: TextStyle(color: BLACK_COLOR, fontSize: 15),
        ),
      ),
    );
  }

  Widget getPostImage(String _image) {
    getImages = _image.split(";");
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(alignment: Alignment.center, children: [
          CarouselSlider.builder(
            itemCount: getImages.length,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (context, index, _) {
              return Stack(
                children: [
                  FullScreenWidget(
                    backgroundColor: WHITE_COLOR,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: getImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 32.0,
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BLACK_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                (currentPos + 1).toString() + "/" + getImages.length.toString(),
                style: TextStyle(fontSize: 13, color: WHITE_COLOR),
              ),
            ),
          ),
        ]),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getImages.map((pic) {
              int index = getImages.indexOf(pic);
              return Container(
                width: currentPos == index ? 8.0 : 6.0,
                height: currentPos == index ? 8.0 : 6.0,
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: GREY_COLOR.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  color: currentPos == index
                      ? WHITE_COLOR
                      : WHITE_COLOR.withOpacity(0.6),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget PostInteraction(PostModel postModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: PINK_COLOR,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.thumb_up,
                  size: 10,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  postModel.totalReaction != null ? postModel.totalReaction.toString() : "0",
                  style: TextStyle(
                    color: LIGHT_DARK_GREY_COLOR,
                  ),
                ),
              ),
              Text(
                "200 Bình luận",
                style: TextStyle(
                  color: LIGHT_DARK_GREY_COLOR,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
        Row(
          children: [
            InteractiveButton(Icons.thumb_up_off_alt_outlined, "Thích"),
            InteractiveButton(Icons.comment_outlined, "Bình luận"),
          ],
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget InteractiveButton(IconData icon, String name) {
    return Expanded(
      child: Material(
        color: WHITE_COLOR,
        child: InkWell(
          onTap: () {
            if(name == "Thích"){

            }else if(name == "Bình luận"){
              showModalBottom();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: LIGHT_DARK_GREY_COLOR.withOpacity(0.6),
                  size: 20,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  name,
                  style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModalBottom() {
    return showModalBottomSheet(
        backgroundColor: TRANSPARENT_COLOR,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.96,
              minChildSize: 0.75,
              maxChildSize: 0.96,
              builder: (context, scrollController) {
                return Scaffold(
                  body: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 40,
                      automaticallyImplyLeading: false,
                      backgroundColor: TRANSPARENT_COLOR,
                      centerTitle: true,
                      shape: Border(
                        bottom: BorderSide(
                            color: LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
                            width: 1),
                      ),
                      title: Text(
                        "200 Bình luận",
                        style: TextStyle(
                            color: BLACK_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: LIGHT_DARK_GREY_COLOR,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 25,
                            itemBuilder: (BuildContext context, int index) {
                              return postComment();
                            },
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          border: Border(top: BorderSide(color: GREY_COLOR))),
                      child:
                          Card(margin: EdgeInsets.zero, child: CommentSection()),
                    ),
                  ),
                );
              });
        });
  }

  Widget CommentSection() {
    bool commentFlag = false;
    return ListTile(
      leading: _momViewModel.momModel == null
          ? CircleAvatar(radius: 20, backgroundColor: LIGHT_GREY_COLOR)
          : CircleAvatar(
              radius: 20,
              backgroundColor: LIGHT_GREY_COLOR,
              backgroundImage:
                  CachedNetworkImageProvider(_momViewModel.momModel.imageURL),
            ),
      title: TextFormField(
        autofocus: true,
        minLines: 1,
        maxLines: 4,
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Viết bình luận...',
          fillColor: LIGHT_GREY_COLOR,
          filled: true,
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: TRANSPARENT_COLOR),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TRANSPARENT_COLOR),
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          suffixIcon: IconButton(
            icon: Icon(Icons.send_rounded,color: commentFlag == true ? PINK_COLOR : GREY_COLOR,size: 28,),
            onPressed: () async{
              commentFlag == true ? handleComment() : null;
            }
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (value != "") {
              commentFlag = true;
            } else {
              commentFlag = false;
            }
          });
        },
      ),
    );
  }

  void handleComment(){
    _controller.clear();
    setState(() {});
  }

  Widget postComment() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: CommentTreeWidget<Comment, Comment>(
        Comment(
            avatar: iconGirl,
            userName: 'Phạm Hoàng Duy',
            content: 'Ngoài ra với công tắc khóa camera mang lại sự bảo mật dữ liệu tốt nhất và tính năng cảm biến vân tay giúp bạn mở thiết bị dễ dàng, tiện lợi hơn, an toàn tuyệt đối chỉ với một chạm.'),
        [
          Comment(
              avatar: iconGirl,
              userName: 'Phạm Hoàng Duy',
              content: 'Ngoài ra với công tắc khóa camera mang lại sự bảo mật dữ liệu tốt nhất và tính năng cảm biến vân tay giúp bạn mở thiết bị dễ dàng, tiện lợi hơn, an toàn tuyệt đối chỉ với một chạm.'),
        ],
        treeThemeData: TreeThemeData(lineColor: TRANSPARENT_COLOR, lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(data.avatar),
          ),
          preferredSize: Size.fromRadius(18),
        ),
        avatarChild: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(data.avatar),
          ),
          preferredSize: Size.fromRadius(12),
        ),
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black,fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black,fontSize: 14),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: LIGHT_DARK_GREY_COLOR.withOpacity(0.7), fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('23 phút'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Thích'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Trả lời'),
                      SizedBox(
                        width: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: PINK_COLOR,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('0'),
                    ],
                  ),
                ),
              )
            ],
          );
        },
        contentChild: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black,fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black,fontSize: 14),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: LIGHT_DARK_GREY_COLOR.withOpacity(0.7), fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('23 phút'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Thích'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Trả lời'),
                      SizedBox(
                        width: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: PINK_COLOR,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('0'),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
