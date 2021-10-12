import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/calculateDate_view.dart';
import 'package:mumbi_app/View/doctor.dart';
import 'package:mumbi_app/core/change_member/models/change_member_model.dart';
import 'package:mumbi_app/modules/community/views/community_view.dart';
import 'package:mumbi_app/modules/family/models/child_model.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/modules/family/views/child_info_view.dart';
import 'package:mumbi_app/modules/news/models/news_model.dart';
import 'package:mumbi_app/modules/news/views/news_details_view.dart';
import 'package:mumbi_app/modules/activity/views/pregnancy_view.dart';
import 'package:mumbi_app/modules/news/viewmodel/news_viewmodel.dart';
import 'package:mumbi_app/widgets/createList.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ChildModel pregnancyModel;
  NewsViewModel _newsViewModel;
  ChildViewModel _childViewModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _newsViewModel = NewsViewModel.getInstance();

    _childViewModel = ChildViewModel.getInstance();
  }

  void _onRefresh() async {
    await _newsViewModel.getNews();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _newsViewModel.getMoreNews();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: WHITE_COLOR,
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
                body = Text(NO_MORE_NEWS_MESSAGE);
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
                  if (CurrentMember.role == MOM_ROLE) PregnancyInfo(),
                  if (CurrentMember.role == CHILD_ROLE) ChildInfo(),
                  createTitle("Tính năng nổi bật"),
                  SalientFeatures(),
                  createTitle("Tin tức mới nhất"),
                  GridViewNews(),
                ],
              ))
            ],
          )),
    );
  }

  Widget PregnancyInfo() {
    return ScopedModel(
        model: _childViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ChildViewModel model) {
            if (model.childListModel != null) {
              for (int i = model.childListModel.length - 1; i >= 0; i--) {
                ChildModel childModel = model.childListModel[i];
                if (childModel.bornFlag == false) {
                  pregnancyModel = childModel;
                  CurrentMember.pregnancyID = childModel.id;
                  CurrentMember.pregnancyFlag = true;
                  break;
                }
              }
            }
            return pregnancyModel == null
                ? createListTileHome(
                    context,
                    LIGHT_GREY_COLOR,
                    empty,
                    "Chưa có thông tin",
                    "Nhấp vào để thêm thông tin thai.",
                    0,
                    "",
                    onClick: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalculateDate(),
                        ),
                      );
                      await _childViewModel.getChildByMom();
                    },
                  )
                : createListTileHome(
                    context,
                    LIGHT_PINK_COLOR,
                    pregnancy,
                    "Tuần thứ ${DateTimeConvert.pregnancyWeek(pregnancyModel.estimatedBornDate)} của thai kì",
                    "",
                    DateTimeConvert.dayUntil(pregnancyModel.estimatedBornDate),
                    PREGNANCY_ROLE,
                    onClick: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChildrenInfo(pregnancyModel,
                                  UPDATE_STATE, PREGNANCY_ENTRY)));
                      await _childViewModel
                          .getChildByID(CurrentMember.pregnancyID);
                    },
                  );
          },
        ));
  }

  Widget ChildInfo() {
    return ScopedModel(
      model: _childViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ChildViewModel model) {
          return model.childModel == null
              ? loadingProgress()
              : createListTileHome(
                  context,
                  LIGHT_BLUE_COLOR,
                  embe,
                  "Bé đã ${DateTimeConvert.calculateChildAge(model.childModel.birthday)}",
                  "",
                  0,
                  CHILD_ROLE,
                  onClick: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildrenInfo(
                                model.childModel, UPDATE_STATE, CHILD_ENTRY)));
                    await _childViewModel.getChildByID(CurrentMember.id);
                  },
                );
        },
      ),
    );
  }

  Widget createNewsItem(
      String _imageURL, String _title, String _estimatedTime, Widget _screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => _screen));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0.1,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Scaffold(
          backgroundColor: WHITE_COLOR,
          body: Ink.image(
            image: CachedNetworkImageProvider(
              _imageURL,
            ),
            height: 125,
            fit: BoxFit.cover,
          ),
          bottomNavigationBar: Container(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                  child: Text(
                    _title,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                          child: SvgPicture.asset(readIcon,
                              height: 16, width: 16)),
                      SizedBox(width: 5),
                      Text(
                        _estimatedTime + " phút đọc",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, color: LIGHT_DARK_GREY_COLOR),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SalientFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createButtonTextImageLink(context, "Cộng đồng", community, Community()),
        createButtonTextImageLink(context, "Thai giáo", thaigiao, Pregnancy()),
        createButtonTextImageLink(context, "Bác sĩ", doctor, Doctor()),
      ],
    );
  }

  Widget GridViewNews() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ScopedModel(
        model: _newsViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, NewsViewModel model) {
            return model.newsListModel == null
                ? loadingProgress()
                : GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2),
                    itemCount: model.newsListModel != null
                        ? model.newsListModel.length
                        : 0,
                    itemBuilder: (BuildContext context, index) {
                      NewsModel newsModel = model.newsListModel[index];
                      return createNewsItem(
                          newsModel.imageURL,
                          newsModel.title,
                          newsModel.estimatedFinishTime.toString(),
                          NewsDetail(newsModel, NORMAL_ENTRY));
                    });
          },
        ),
      ),
    );
  }
}
