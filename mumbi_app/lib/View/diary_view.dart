import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
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
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, DiaryViewModel model) {
        return Scaffold(
          backgroundColor: LIGHT_GREY_COLOR,
          appBar: AppBar(
            title: ScopedModel(
                model: _childViewModel,
                child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
                  return Text("Nhật ký của ${model.childModel != null ? model.childModel.fullName : "..."}");
                },)),
          ),
          body: model.childDiaryListModel == null
              ? createEmptyDiary(context)
              : ListView.builder(
            itemCount: model.childDiaryListModel != null ? model.childDiaryListModel.length : 0,
            itemBuilder: (context, index) {
              DiaryModel diaryModel = model.childDiaryListModel[index];
              return createDiaryItem(context, diaryModel,onClick: () async{
                await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BabyDiaryDetails(diaryModel)));
                await _diaryViewModel.getChildDiary(CurrentMember.id);
              });
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBabyDiary()));
              await _diaryViewModel.getChildDiary(CurrentMember.id);
            },
            label: Text('Viết nhật ký'),
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


