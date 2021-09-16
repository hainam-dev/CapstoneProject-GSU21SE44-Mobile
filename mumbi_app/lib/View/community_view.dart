import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/addCommunityPost.dart';
import 'package:mumbi_app/ViewModel/communityPost_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
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
  MomViewModel _momViewModel;

  @override
  void initState() {
    super.initState();
    _communityViewModel = CommunityViewModel.getInstance();
    _communityViewModel.getCommunityPost();

    _momViewModel = MomViewModel.getInstance();

    if(getImages != null && getImages != "")
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
      body: listCommunityPost(),
    );
  }

  Widget listCommunityPost() {
    return Column(
      children: [
        Card(
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCommunityPost(),));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: LIGHT_GREY_COLOR,
                ),
                width: SizeConfig.safeBlockHorizontal * 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hôm nay bạn có gì?",style: TextStyle(color: GREY_COLOR),),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        ScopedModel(
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
                          return showCommunityPost(postModel);
                        },
                      ),
                  );
            },
          ),
        ),
      ],
    );
  }

  Widget showCommunityPost(PostModel postModel) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(postModel.avatar),
              ),
              title: Text(
                postModel.fullName,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle:
                  Text(DateTimeConvert.timeAgoSinceDate(postModel.approvedTime)),
              trailing: postModel.userId == _momViewModel.momModel.id
                  ? PopupMenuButton<String>(
                      onSelected: (value) async {
                        switch (value) {
                          case 'Xóa bài viết':
                            showProgressDialogue(context);
                            bool result = false;
                            result = await CommunityViewModel().deleteCommunityPost(postModel.id);
                            await _communityViewModel.getCommunityPost();
                            Navigator.pop(context);
                            showResult(context, result,
                                "Bài viết đã được xóa khỏi mục cộng đồng");
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
            ),
            if (postModel.imageURL != null && postModel.imageURL != "")
              getPostImage(postModel.imageURL),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                child: ReadMoreText(
                  postModel.postContent,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget getPostImage(String _image) {
    getImages = _image.split(";");
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
            alignment: Alignment.center,
            children: [
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
                      child: Hero(
                        tag: getImages[index].toString(),
                        child: CachedNetworkImage(
                          imageUrl: getImages[index],
                          fit: BoxFit.cover,
                        ),
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
                style: TextStyle(fontSize: 13,color: WHITE_COLOR),
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
}
