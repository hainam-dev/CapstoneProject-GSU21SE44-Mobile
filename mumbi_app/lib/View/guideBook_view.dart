import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/guidebookDetails_view.dart';
import 'package:mumbi_app/ViewModel/guidebook_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class GuideBook extends StatefulWidget {
  final model;

  const GuideBook(this.model);

  @override
  _GuideBookState createState() => _GuideBookState();
}

class _GuideBookState extends State<GuideBook> {

  GuidebookViewModel _guidebookViewModel;

  @override
  void initState() {
    super.initState();
    _guidebookViewModel = new GuidebookViewModel();
    _guidebookViewModel.getGuidebookByType(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        title: Text('Cẩm nang'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Text(widget.model.type,
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Text(checkQuantity(widget.model.postQuantity).toString() + " bài",
            style: TextStyle(fontSize: 20,color: LIGHT_DARK_GREY_COLOR),),
          SizedBox(height: 10,),
          ScopedModel(
              model: _guidebookViewModel,
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
                              /*if (index == 0) {
                                return GuidebookFirstItem(context, guidebookModel);
                              }*/
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


  Widget GuidebookFirstItem(context, GuidebookModel guidebookModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuidebookDetail(guidebookModel),
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
                  textAlign: TextAlign.center,
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
              builder: (context) => GuidebookDetail(guidebookModel),
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
                  height: 75,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: guidebookModel.imageURL,
                      fit: BoxFit.cover,
                      height: 75,
                      width: 100,
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
                        maxLines: 2,
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

  Widget Empty(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Column(
        children: [
          SvgPicture.asset(emptybox,height: 180,),
          SizedBox(height: 10,),
          Text("Danh mục này chưa có bài viết nào :<",style: TextStyle(fontSize: 20),),
        ],
      )),
    );
  }

  num checkQuantity(num quantity){
    if(quantity != null){
      return quantity;
    }else{
      return 0;
    }
  }

}

