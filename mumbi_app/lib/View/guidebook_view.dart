import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Model/guidebookType_model.dart';
import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/drawer_view.dart';
import 'package:mumbi_app/View/guidebookDetails_view.dart';
import 'package:mumbi_app/View/savedPost_view.dart';
import 'package:mumbi_app/ViewModel/guidebookType_viewmodel.dart';
import 'package:mumbi_app/ViewModel/guidebook_viewmodel.dart';
import 'package:mumbi_app/Widget/customCarouselSlider.dart';
import 'package:mumbi_app/Widget/customCard.dart';
import 'package:mumbi_app/Widget/customEmpty.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookCategory extends StatefulWidget {
  @override
  _GuidebookCategoryState createState() => _GuidebookCategoryState();
}

class _GuidebookCategoryState extends State<GuidebookCategory> {

  GuidebookTypeViewModel guidebookTypeViewModel;
  GuidebookViewModel guidebookViewModel;
  GuidebookViewModel hlGuidebookViewModel;
  num CurrentTypeId;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    guidebookTypeViewModel = GuidebookTypeViewModel.getInstance();
    guidebookViewModel = new GuidebookViewModel();
    hlGuidebookViewModel = new GuidebookViewModel();

    await guidebookTypeViewModel.getAllType();
    num firstId = guidebookTypeViewModel.guidebookTypeListModel.first.id;
    CurrentTypeId = firstId;

    await hlGuidebookViewModel.getGuidebook(true, firstId);
    await guidebookViewModel.getGuidebook(false, firstId);
  }

  void _onRefresh() async {
    await hlGuidebookViewModel.getGuidebook(true, CurrentTypeId);
    await guidebookViewModel.getGuidebook(false, CurrentTypeId);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await guidebookViewModel.getMoreGuidebook(false, CurrentTypeId);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          ButtonGotoSavePost(context),
        ],
      ),
      drawer: getDrawer(context),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode == LoadStatus.loading){
              body =  loadingProgress();
            } else {
              body = Text(NO_MORE_GUIDEBOOK_MESSAGE);
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildListDelegate(
              [
                GuidebookType(),
                Divider(height: 0,),
                HighLightsGuidebook(),
                NormalGuidebook(),
              ],
            ))
          ],
        )
      ),
    );
  }

  Widget GuidebookType(){
    return ScopedModel(
        model: guidebookTypeViewModel,
        child: ScopedModelDescendant(
          builder:
              (BuildContext context, Widget child,
              GuidebookTypeViewModel model) {
            return model.guidebookTypeListModel == null
                ? loadingProgress()
                : Container(
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: model.guidebookTypeListModel.length,
                itemBuilder: (BuildContext context, index) {
                  GuidebookTypeModel guidebookTypeModel =
                  model.guidebookTypeListModel[index];
                  return TypeItem(context, guidebookTypeModel);
                },
              ),
            );
          },
        ));
  }

  Widget HighLightsGuidebook(){
    return ScopedModel(
        model: hlGuidebookViewModel,
        child: ScopedModelDescendant(
          builder:
              (BuildContext context, Widget child,
              GuidebookViewModel model) {
            return model.isLoading == true
                ? InvisibleBox()
                : model.guidebookListModel == null
                ? InvisibleBox()
                : customCarouselSlider(
              context,
              model.guidebookListModel.length,
              itemBuilder: (context, index, realIndex) {
                GuidebookModel guidebookModel =
                model.guidebookListModel[index];
                return HighLightsCardItem(
                  guidebookModel.imageURL,
                  guidebookModel.title,
                  guidebookModel.createTime,
                  guidebookModel.estimatedFinishTime,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GuidebookDetail(
                                  guidebookModel, NORMAL_ENTRY),
                        ));
                  },
                );
              },
            );
          },
        ));
  }

  Widget NormalGuidebook(){
    return ScopedModel(
        model: guidebookViewModel,
        child: ScopedModelDescendant(
          builder:
              (BuildContext context, Widget child,
              GuidebookViewModel model) {
            return model.isLoading == true
                ? loadingProgress()
                : model.guidebookListModel == null
                ? Empty("", "Danh mục này chưa có bài viết nào")
                : Column(
              children: [
                for (var guidebookModel in model.guidebookListModel)
                  NormalCardItem(guidebookModel.imageURL,
                    guidebookModel.title,
                    guidebookModel.createTime,
                    guidebookModel.estimatedFinishTime,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GuidebookDetail(
                                    guidebookModel, NORMAL_ENTRY),
                          ));
                    },
                  ),
              ],
            );
          },
        ));
  }

  Widget TypeItem(BuildContext context, GuidebookTypeModel guidebookTypeModel) {
    return GestureDetector(
      onTap: () {
        if(CurrentTypeId != guidebookTypeModel.id){
          hlGuidebookViewModel.getGuidebook(true, guidebookTypeModel.id);
          guidebookViewModel.getGuidebook(false, guidebookTypeModel.id);
          CurrentTypeId = guidebookTypeModel.id;
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
        child: Card(
          color: guidebookTypeModel.id == CurrentTypeId
              ? LIGHT_PINK_COLOR
              : WHITE_COLOR,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(child: Text(guidebookTypeModel.type, style: TextStyle(
              fontSize: 18,
              color: guidebookTypeModel.id == CurrentTypeId
                  ? DARK_PINK_COLOR
                  : LIGHT_DARK_GREY_COLOR.withOpacity(0.5),),)),
          ),
        ),
      ),
    );
  }

  Widget RelatedPost() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 10, 8),
      child: Text(
        "Tin tức cùng chủ đề",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: PINK_COLOR),
      ),
    );
  }

  Widget ButtonGotoSavePost(context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
            icon: Image(
              image: AssetImage(saved),
              height: ICON_HEIGHT,
              width: ICON_WIDTH,
            ),
            onPressed: () =>
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedPost(0)),
              )
            }),
      ),
    );
  }

}
