import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/community_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:readmore/readmore.dart';
import 'package:scoped_model/scoped_model.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,
      appBar: AppBar(
        title: Text("Cộng đồng"),
      ),
      body: listCommunityPost(),
    );
  }

  Widget listCommunityPost(){
    return ScopedModel(
      model: CommunityViewModel.getInstance(),
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, CommunityViewModel model) {
          model.getPublicDiary();
          return model.publicDiaryListModel == null
              ? loadingProgress()
              : ListView.builder(
            itemCount: model.publicDiaryListModel.length,
            itemBuilder: (context, index) {
              DiaryModel diaryModel = model.publicDiaryListModel[index];
              return showCommunityPost(diaryModel.avatarUser,
                  diaryModel.createdByName, diaryModel.publicDate, diaryModel.diaryContent, diaryModel.imageURL);
            },
          );
        },
      ),
    );
  }

  Widget showCommunityPost(
      String _avatarImageURL, String _username, String _createTime, String _content, String _imageContent) {
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
                backgroundImage: NetworkImage(_avatarImageURL),
              ),
              title: Text(
                _username,
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
              ),
              subtitle: Text(DateTimeConvert.timeAgoSinceDate(_createTime)),
            ),
            if(_avatarImageURL != null)
            Container(
              color: BLACK_COLOR,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: CachedNetworkImage(
                imageUrl: _imageContent,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                child: ReadMoreText(
                  _content,
                  trimLength: 250,
                  colorClickableText: BLACK_COLOR,
                  delimiter: "",
                  trimCollapsedText: '... Xem thêm',
                  trimExpandedText: ' Thu gọn',
                  moreStyle: TextStyle(fontWeight: FontWeight.w600),
                  lessStyle: TextStyle(fontWeight: FontWeight.w600),
                  style: TextStyle(color: BLACK_COLOR,fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
