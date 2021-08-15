import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/community_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:readmore/readmore.dart';
import 'package:scoped_model/scoped_model.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  CommunityViewModel _communityViewModel;
  MomViewModel _momViewModel;

  @override
  void initState() {
    super.initState();
    _communityViewModel = CommunityViewModel.getInstance();
    _communityViewModel.getPublicDiary();

    _momViewModel = MomViewModel.getInstance();
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

  Widget listCommunityPost(){
    return ScopedModel(
      model: _communityViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, CommunityViewModel model) {
          return model.publicDiaryListModel == null
              ? loadingProgress()
              : ListView.builder(
            itemCount: model.publicDiaryListModel.length,
            itemBuilder: (context, index) {
              DiaryModel diaryModel = model.publicDiaryListModel[index];
              return showCommunityPost(diaryModel);
            },
          );
        },
      ),
    );
  }

  Widget showCommunityPost(DiaryModel diaryModel) {
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
                backgroundImage: NetworkImage(diaryModel.avatarUser),
              ),
              title: Text(
                diaryModel.createdByName,
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
              ),
              subtitle: Text(DateTimeConvert.timeAgoSinceDate(diaryModel.publicDate)),
              trailing: diaryModel.createdByID == _momViewModel.momModel.id ? PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'Bỏ chia sẻ cộng đồng':
                      bool result = false;
                      diaryModel.publicDate = "1900-01-01T00:00:00.000";
                      diaryModel.publicFlag = false;
                      diaryModel.approvedFlag = false;
                      result = await DiaryViewModel().updateDiary(diaryModel);
                      await _communityViewModel.getPublicDiary();
                      showResult(context, result, "Bài viết đã được gỡ khỏi mục cộng đồng");
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Bỏ chia sẻ cộng đồng'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
                  : SizedBox.shrink(),
            ),
            if(diaryModel.imageURL != null)
            Container(
              color: BLACK_COLOR,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: CachedNetworkImage(
                imageUrl: diaryModel.imageURL,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                child: ReadMoreText(
                  diaryModel.diaryContent,
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
