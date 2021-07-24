import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: DiaryViewModel.getInstance(),
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, DiaryViewModel model) {
        model.getChildDiary(CurrentMember.id);
        return Scaffold(
          backgroundColor: LIGHT_GREY_COLOR,
          appBar: AppBar(
            title: ScopedModel(
                model: ChildViewModel.getInstance(),
                child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
                  return Text("Nhật ký của ${model.childModel.fullName}",maxLines: 1,overflow: TextOverflow.ellipsis,);
                },)),
          ),
          body: model.childDiaryListModel == null
              ? createEmptyDiary(context)
              : ListView.builder(
            itemCount: model.childDiaryListModel.length,
            itemBuilder: (context, index) {
              DiaryModel diaryModel = model.childDiaryListModel[index];
              return createDiaryItem(context, diaryModel);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBabyDiary()));
            },
            label: Text('Thêm nhật ký'),
            icon: Image.asset(
              addDiary,
            ),
            backgroundColor: PINK_COLOR,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },),
    );
  }
}


