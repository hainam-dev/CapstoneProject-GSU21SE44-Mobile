import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/baby_development.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/community_view.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/newsDetails_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        actions: [
          ChangeAccountButton(context),
        ],
      ),
      drawer: getDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(CurrentMember.role == "Mẹ")
              ScopedModel(
                  model: ChildViewModel.getInstance(),
                  child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
                    model.getChildByMom();
                    if(model.childListModel != null){
                      for(int i = model.childListModel.length - 1; i >= 0 ; i--){
                        ChildModel childModel = model.childListModel[i];
                        if(childModel.bornFlag == false){
                          pregnancyModel = childModel;
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
                        "Nhấp vào để thêm thông tin bé/thai kì.",
                        ChildrenInfo("", "Create"))
                        : createListTileHome(
                        context,
                        LIGHT_PINK_COLOR,
                        pregnancy,
                        DateTimeConvert.dayUntil(pregnancyModel.estimatedBornDate),
                        "",
                        ChildrenInfo(pregnancyModel, "Update"));
              },)),

            if(CurrentMember.role == "Con")
              ScopedModel(
                model: ChildViewModel.getInstance(),
                child: ScopedModelDescendant(builder: (context, child, ChildViewModel model) {
                  model.getChildByID(CurrentMember.id);
                  return model.childModel == null
                      ? loadingProgress()
                      : createListTileHome(
                      context,
                      LIGHT_BLUE_COLOR,
                      embe,
                      DateTimeConvert.calculateAge(model.childModel.birthday),
                      "",
                      ChildrenInfo(model.childModel, "Update"));
                },),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: createTitle("Tính năng nổi bật")),
            ),
            SalientFeatures(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: createTitle("Tin tức mới nhất")),
            ),
            GridViewNews(),
          ],
        ),
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
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          elevation: 1.6,
          child: Scaffold(
            backgroundColor: WHITE_COLOR,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(6.0)),
                  child: CachedNetworkImage(imageUrl: _imageURL)),
            ),
            bottomNavigationBar: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 4),
                  child: Text(
                    _title,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(readIcon),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      _estimatedTime + " phút đọc",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, color: LIGHT_DARK_GREY_COLOR),
                    ),
                  ],
                ),
              ],
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
              MaterialPageRoute(builder: (context) => ChangeAccount()));
          },
        child: Row(
          children: [
            MomAvatar(),
            if(CurrentMember.role == "Con")
              Row(
                children: [
                  Icon(Icons.all_inclusive,color: WHITE_COLOR,size: 19,),
                  ChildAvatar(),
                ],
              )
          ],
        ));
  }

  Widget MomAvatar(){
    return ScopedModel(
      model: MomViewModel.getInstance(),
      child: ScopedModelDescendant(builder:
          (BuildContext buildContext, Widget child, MomViewModel model) {
        model.getMomByID();
        return model.momModel == null
                    ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,)
                    : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage: CachedNetworkImageProvider(
                            model.momModel.imageURL),
                      ),
                    );
      }),
    );
  }

  Widget ChildAvatar(){
    return ScopedModel(
        model: ChildViewModel.getInstance(),
        child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
          model.getChildByID(CurrentMember.id);
           return model.childModel == null
               ? CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 18,)
               : CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 18,
                 child: CircleAvatar(
                   radius: 17,
                   backgroundImage: CachedNetworkImageProvider(
                       model.childModel.imageURL),
                 ),
               );
    },));
  }

  Widget SalientFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createButtonTextImageLink(
            context, "Tiêm chủng", injection, InjectionSchedule()),
        createButtonTextImageLink(context, "Cộng đồng", community, Community()),
        createButtonTextImageLink(
            context, "Mốc phát triển", developmentMilestone, BabyDevelopment()),
      ],
    );
  }

  Widget GridViewNews() {
    return ScopedModel(
      model: NewsViewModel.getInstance(),
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, NewsViewModel model) {
          model.getAllNews();
          return model.newsListModel == null
              ? loadingProgress()
              : Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: model.newsListModel != null ? model.newsListModel.length : 0,
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
