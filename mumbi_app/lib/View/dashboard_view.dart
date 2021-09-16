import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/babyDevelopment_view.dart';
import 'package:mumbi_app/View/calculateDate_view.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/community_view.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/newsDetails_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/news_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'drawer_view.dart';
import 'changeAccount_view.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ChildModel pregnancyModel;
  NewsViewModel _newsViewModel;
  MomViewModel _momViewModel;
  ChildViewModel _childViewModel;

  @override
  void initState() {
    super.initState();
    _newsViewModel = NewsViewModel.getInstance();
    _newsViewModel.getAllNews();

    _momViewModel = MomViewModel.getInstance();
    _momViewModel.getMomByID();

    _childViewModel = ChildViewModel.getInstance();
    _childViewModel.getChildByMom();

    if (CurrentMember.role == CHILD_ROLE)
      _childViewModel.getChildByID(CurrentMember.id);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        title: Text("Trang chủ"),
        actions: [
          ChangeAccountButton(context),
        ],
      ),
      drawer: getDrawer(context),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (CurrentMember.role == MOM_ROLE) PregnancyInfo(),
          if (CurrentMember.role == CHILD_ROLE) ChildInfo(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Align(
                alignment: Alignment.topLeft,
                child: createTitle("Tính năng nổi bật")),
          ),
          SalientFeatures(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Align(
                alignment: Alignment.topLeft,
                child: createTitle("Tin tức mới nhất")),
          ),
          GridViewNews(),
        ],
      ),
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
                    "Nhấp vào để thêm thông tin thai kì.",
                    0,
                    "",
                    onClick: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          CalculateDate(),
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
                    "Bạn còn ${DateTimeConvert.dayUntil(pregnancyModel.estimatedBornDate)} ngày để gặp được bé",
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _screen));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Scaffold(
            backgroundColor: WHITE_COLOR,
            body: Ink.image(image: CachedNetworkImageProvider(_imageURL,),height: 130,fit: BoxFit.cover,),
            bottomNavigationBar: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 5,top: 5,bottom: 5),
                    child: Text(
                      _title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10,left: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Container(child: SvgPicture.asset(readIcon,height: 16, width: 16)),
                        SizedBox(width: 5),
                        Text(
                          _estimatedTime + " phút đọc",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontSize: 14, color: LIGHT_DARK_GREY_COLOR),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ChangeAccountButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangeAccount(2)));
        },
        child: Row(
          children: [
            MomAvatar(),
            if (CurrentMember.role == CHILD_ROLE)
              Row(
                children: [
                  Icon(
                    Icons.all_inclusive,
                    color: WHITE_COLOR,
                    size: 19,
                  ),
                  ChildAvatar(),
                ],
              )
          ],
        ));
  }

  Widget MomAvatar() {
    return ScopedModel(
      model: _momViewModel,
      child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MomViewModel model) {
        return model.momModel == null
            ? CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
              )
            : CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: CircleAvatar(
                  radius: 17,
                  backgroundImage:
                      CachedNetworkImageProvider(model.momModel.imageURL),
                ),
              );
      }),
    );
  }

  Widget ChildAvatar() {
    return ScopedModel(
        model: _childViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ChildViewModel model) {
            return model.childModel == null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundImage:
                          CachedNetworkImageProvider(model.childModel.imageURL),
                    ),
                  );
          },
        ));
  }

  Widget SalientFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createButtonTextImageLink(
            context, "Tiêm chủng", injection, checkEntryInjectionSchedule()),
        createButtonTextImageLink(context, "Cộng đồng", community, Community()),
      ],
    );
  }

  Widget checkEntryInjectionSchedule() {
    if (CurrentMember.role == MOM_ROLE) {
      return ChangeAccount(2);
    } else {
      return InjectionSchedule();
    }
  }

  Widget GridViewNews() {
    return ScopedModel(
      model: _newsViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, NewsViewModel model) {
          return model.newsListModel == null
              ? loadingProgress()
              : Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                      itemCount: model.newsListModel != null
                          ? model.newsListModel.length
                          : 0,
                      itemBuilder: (BuildContext context, index) {
                        NewsModel newsModel = model.newsListModel[index];
                        return createNewsItem(
                            newsModel.imageURL,
                            newsModel.title,
                            newsModel.estimatedFinishTime.toString(),
                            NewsDetail(newsModel));
                      }),
                );
        },
      ),
    );
  }
}
