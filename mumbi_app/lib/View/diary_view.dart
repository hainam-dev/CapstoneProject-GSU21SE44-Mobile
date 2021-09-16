import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/babyDiaryDetails_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:scoped_model/scoped_model.dart';

import 'addBabyDiary_view.dart';

class BabyDiary extends StatefulWidget {
  @override
  _BabyDiaryState createState() => _BabyDiaryState();
}

class _BabyDiaryState extends State<BabyDiary> {
  DiaryViewModel _diaryViewModel;
  ChildViewModel _childViewModel;

  @override
  void initState() {
    super.initState();
    _diaryViewModel = DiaryViewModel.getInstance();
    _diaryViewModel.getChildDiary(CurrentMember.id);

    _childViewModel = ChildViewModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _diaryViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, DiaryViewModel model) {
          return Scaffold(
            backgroundColor: LIGHT_GREY_COLOR,
            appBar: AppBar(
              title: Text("Nhật ký"),
            ),
            body: Column(
              children: [
                ChildInfo(_childViewModel.childModel),
                model.childDiaryListModel == null
                    ? createEmptyDiary(context)
                    : Expanded(
                      child: ListView.builder(
                        itemCount: model.childDiaryListModel != null
                            ? model.childDiaryListModel.length
                            : 0,
                        itemBuilder: (context, index) {
                          DiaryModel diaryModel = model.childDiaryListModel[index];
                          return createDiaryItem(context, diaryModel,
                              onClick: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BabyDiaryDetails(diaryModel)));
                                await _diaryViewModel.getChildDiary(CurrentMember.id);
                              });
                        },
                      ),
                    ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBabyDiary()));
                await _diaryViewModel.getChildDiary(CurrentMember.id);
              },
              child: SvgPicture.asset(add,height: 23,width: 23,color: PINK_COLOR,),
              backgroundColor: WHITE_COLOR,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }

  Widget ChildInfo(ChildModel childModel) {
    return Container(
        decoration:
        new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: GREY_COLOR)
            )
        ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: childModel == null
              ? CircleAvatar(radius: 22, backgroundColor: LIGHT_GREY_COLOR)
              : CircleAvatar(
            radius: 22,
            backgroundColor: LIGHT_GREY_COLOR,
            backgroundImage:
            CachedNetworkImageProvider(childModel.imageURL),
          ),
          title: Text(
            childModel == null ? "..." : childModel.fullName,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            childModel == null ? "..." : DateTimeConvert.calculateChildAge(childModel.birthday),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),),
      ),
    );
  }

}
