import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/guidebookType_model.dart';
import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/drawer_view.dart';
import 'package:mumbi_app/View/guidebookDetails_view.dart';
import 'package:mumbi_app/View/savedPost_view.dart';
import 'package:mumbi_app/ViewModel/guidebookType_viewmodel.dart';
import 'package:mumbi_app/ViewModel/guidebook_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookCategory extends StatefulWidget {
  @override
  _GuidebookCategoryState createState() => _GuidebookCategoryState();
}

class _GuidebookCategoryState extends State<GuidebookCategory> {

  GuidebookTypeViewModel guidebookTypeViewModel;
  GuidebookViewModel guidebookViewModel;
  num CurrentTypeId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    guidebookTypeViewModel = GuidebookTypeViewModel.getInstance();
    guidebookViewModel = new GuidebookViewModel();

    await guidebookTypeViewModel.getAllType();

    num firstId = guidebookTypeViewModel.guidebookTypeListModel.first.id;
    CurrentTypeId = firstId;
    await guidebookViewModel.getGuidebookByType(firstId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          GotoSavePostButton(context),
        ],
      ),
      drawer: getDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScopedModel(
              model: guidebookTypeViewModel,
              child: ScopedModelDescendant(
                builder:
                    (BuildContext context, Widget child, GuidebookTypeViewModel model) {
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
              )),
          Divider(height: 0,),
          ScopedModel(
              model: guidebookViewModel,
              child: ScopedModelDescendant(
                builder:
                    (BuildContext context, Widget child, GuidebookViewModel model) {
                  return model.isLoading == true
                      ? loadingProgress()
                      : model.guidebookListModel == null
                      ? Empty()
                      : Expanded(
                    child: ListView.builder(
                      itemCount: model.guidebookListModel.length,
                      itemBuilder: (BuildContext context, index) {
                        GuidebookModel guidebookModel =
                        model.guidebookListModel[index];
                        if (index == 0) {
                                return GuidebookFirstItem(context, guidebookModel);
                              }
                        return GuidebookItem(context, guidebookModel);
                      },
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget TypeItem(BuildContext context,GuidebookTypeModel guidebookTypeModel){
    return GestureDetector(
      onTap: () {
        guidebookViewModel.getGuidebookByType(guidebookTypeModel.id);
        CurrentTypeId = guidebookTypeModel.id;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(left: 5,top: 5,bottom: 5),
        child: Card(
          color: guidebookTypeModel.id == CurrentTypeId ? LIGHT_PINK_COLOR : WHITE_COLOR,
          elevation: 0,
          shape: RoundedRectangleBorder(
            /*side: BorderSide(
              color: guidebookTypeModel.id == CurrentTypeId ? PINK_COLOR : LIGHT_DARK_GREY_COLOR.withOpacity(0.5),
            ),*/
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(child: Text(guidebookTypeModel.type,style: TextStyle(fontSize: 18,color: guidebookTypeModel.id == CurrentTypeId ? DARK_PINK_COLOR : LIGHT_DARK_GREY_COLOR.withOpacity(0.5),),)),
          ),
        ),
      ),
    );
  }

  Widget GuidebookFirstItem(context, GuidebookModel guidebookModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuidebookDetail(guidebookModel,NORMAL_ENTRY),
            ));
      },
      child: Container(
        color: WHITE_COLOR,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: LIGHT_GREY_COLOR,
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Ink.image(
                    image: CachedNetworkImageProvider(guidebookModel.imageURL,),height: 200,fit: BoxFit.cover,)
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Text(
                  guidebookModel.title,
                  style:
                  TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateTimeConvert.convertDatetimeDMY(
                          guidebookModel.createTime),
                      style:
                      TextStyle(fontSize: 15, color: LIGHT_DARK_GREY_COLOR),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.fiber_manual_record,
                      color: GREY_COLOR,
                      size: 6,
                    ),
                    SizedBox(width: 6),
                    Text(
                      guidebookModel.estimatedFinishTime.toString() +
                          " phút đọc",
                      style: TextStyle(fontSize: 15,color: LIGHT_DARK_GREY_COLOR),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget GuidebookItem(context, GuidebookModel guidebookModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuidebookDetail(guidebookModel,NORMAL_ENTRY),
            ));
      },
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: LIGHT_GREY_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 90,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: guidebookModel.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        guidebookModel.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                              DateTimeConvert.convertDatetimeDMY(
                                  guidebookModel.createTime),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: LIGHT_DARK_GREY_COLOR)),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: GREY_COLOR,
                            size: 6,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            guidebookModel.estimatedFinishTime.toString() +
                                " phút đọc",
                            style: TextStyle(
                                fontSize: 14, color: LIGHT_DARK_GREY_COLOR),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget GotoSavePostButton(context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
            icon: Image(
              image: AssetImage(saved),
              height: SizeConfig.blockSizeVertical * 8,
              width: SizeConfig.blockSizeHorizontal * 8,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedPost(0)),
              )
            }),
      ),
    );
  }

  Widget Empty(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(emptybox,height: 160,),
            SizedBox(height: 10,),
            Align(alignment: Alignment.center ,child: Text("Danh mục này chưa có bài viết nào",style: TextStyle(fontSize: 18),)),
          ],
        ),
      ),
    );
  }
}
