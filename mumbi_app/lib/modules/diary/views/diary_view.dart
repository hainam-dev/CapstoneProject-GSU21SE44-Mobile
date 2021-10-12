import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/core/change_member/models/change_member_model.dart';
import 'package:mumbi_app/modules/diary/viewmodel/diary_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/widgets/createList.dart';
import 'package:mumbi_app/widgets/customCard.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

import 'add_diary_view.dart';
import 'diary_details_view.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DiaryViewModel _diaryViewModel;
  ChildViewModel _childViewModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _diaryViewModel = DiaryViewModel.getInstance();
    _diaryViewModel.getChildDiary(CurrentMember.id);

    _childViewModel = ChildViewModel.getInstance();
  }

  void _onRefresh() async {
    await _diaryViewModel.getChildDiary(CurrentMember.id);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _diaryViewModel.getMoreChildDiary(CurrentMember.id);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHT_GREY_COLOR,
      appBar: AppBar(
        title: Text("Nhật ký"),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.loading) {
                body = loadingProgress();
              } else {
                body = Text(NO_MORE_DIARY_MESSAGE);
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
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  CardInfo(
                      _childViewModel.childModel.imageURL,
                      _childViewModel.childModel.fullName,
                      _childViewModel.childModel.birthday),
                  DiaryList(),
                ],
              ))
            ],
          )),
      floatingActionButton: GotoAddDiary(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget DiaryList() {
    return ScopedModel(
        model: _diaryViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, DiaryViewModel model) {
            return model.childDiaryListModel == null
                ? createEmptyDiary(context)
                : Column(
                    children: [
                      for (var diaryModel in model.childDiaryListModel)
                        createDiaryItem(context, diaryModel, onClick: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DiaryDetails(diaryModel)));
                          await _diaryViewModel.getChildDiary(CurrentMember.id);
                        }),
                    ],
                  );
          },
        ));
  }

  Widget GotoAddDiary() {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddDiary()));
        await _diaryViewModel.getChildDiary(CurrentMember.id);
      },
      child: SvgPicture.asset(pencil, height: 18, width: 18),
      backgroundColor: PINK_COLOR,
    );
  }
}
