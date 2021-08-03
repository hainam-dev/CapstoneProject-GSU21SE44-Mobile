import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/guidebookDetails_view.dart';
import 'package:mumbi_app/ViewModel/guidebook_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'drawer_view.dart';
import 'package:mumbi_app/View/savedPost_view.dart';

class GuideBook extends StatefulWidget {
  @override
  _GuideBookState createState() => _GuideBookState();
}

class _GuideBookState extends State<GuideBook> {

  GuidebookViewModel _guidebookViewModel;

  @override
  void initState() {
    super.initState();
    _guidebookViewModel = GuidebookViewModel.getInstance();
    _guidebookViewModel.getAllGuidebook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          // CircleAvatar(
          //   backgroundColor: Colors.white,
          //   child: IconButton(icon: Icon(Icons.search), onPressed: () => {}),
          // ),
          GotoSavePostButton(context),
        ],
      ),
      drawer: getDrawer(context),
      body: ScopedModel(
          model: _guidebookViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, GuidebookViewModel model) {
              return model.guidebookListModel == null
                  ? loadingProgress()
                  : ListView.builder(
                      itemCount: model.guidebookListModel.length <= 7
                          ? model.guidebookListModel.length
                          : 7,
                      itemBuilder: (BuildContext context, index) {
                        GuidebookModel guidebookModel =
                            model.guidebookListModel[index];
                        if (index == 0) {
                          return GuidebookFirstItem(context, guidebookModel);
                        }
                        return GuidebookItem(context, guidebookModel);
                      },
                    );
            },
          )),
    );
  }
}

Widget GotoSavePostButton(context) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 12),
    child: CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
          icon: Icon(Icons.bookmark_border_outlined,color: BLACK_COLOR,),
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedPost(1)),
                )
              }),
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
    child: Column(
      children: [
        Container(
          color: WHITE_COLOR,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: SizeConfig.blockSizeVertical * 30,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: guidebookModel.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      guidebookModel.title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          ),
        ),
      ],
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
    child: Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: guidebookModel.imageURL,
                    fit: BoxFit.cover,
                    height: 75,
                    width: 95,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          guidebookModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
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
    ),
  );
}
