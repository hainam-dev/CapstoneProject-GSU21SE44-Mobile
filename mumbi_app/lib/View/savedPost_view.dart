import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/savedGuidebook_model.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/guidebookDetails_view.dart';
import 'package:mumbi_app/View/newsDetails_view.dart';
import 'package:mumbi_app/ViewModel/savedGuidebook_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedPost extends StatefulWidget {
  @override
  _SavedPostState createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  String SavedNewsId;
  String SavedGuidebookId;

  num _initialIndex = 0;

  @override
  void initState() {
    _initialIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bài viết đã lưu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Tin tức"),
              Tab(text: "Cẩm nang"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SavedNewsList(),
            SavedGuidebookList(),
          ],
        ),
      ),
    );
  }
}


Widget SavedNewsList(){
  return ScopedModel(
      model: SavedNewsViewModel.getInstance(),
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, SavedNewsViewModel model) {
          model.getSavedNewsByMom();
          return model.savedNewsListModel == null
              ? loadingProgress()
              : ListView.builder(
            itemCount: model.savedNewsListModel.length,
            itemBuilder: (BuildContext context, index) {
              SavedNewsModel savedNewsModel = model.savedNewsListModel[index];
              return NewsItem(context, savedNewsModel);
            },
          );
        },
      ));
}

Widget SavedGuidebookList(){
  return ScopedModel(
      model: SavedGuidebookViewModel.getInstance(),
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, SavedGuidebookViewModel model) {
          model.getSavedGuidebookByMom();
          return model.savedGuidebookListModel == null
              ? loadingProgress()
              : ListView.builder(
            itemCount: model.savedGuidebookListModel.length,
            itemBuilder: (BuildContext context, index) {
              SavedGuidebookModel savedGuidebookModel = model.savedGuidebookListModel[index];
              return GuidebookItem(context, savedGuidebookModel);
            },
          );
        },
      ));
}

Widget NewsItem(context, SavedNewsModel savedNewsModel) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(savedNewsModel),
          ));
    },
    child: Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: savedNewsModel.imageURL,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 90,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          savedNewsModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Text(
                              DateTimeConvert.convertDatetimeDMY(
                                  savedNewsModel.createTime),
                              style: TextStyle(fontSize: 15.0, color: LIGHT_DARK_GREY_COLOR)),
                          SizedBox(width: 6,),
                          Icon(
                            Icons.fiber_manual_record,
                            color: GREY_COLOR,
                            size: 6,
                          ),
                          SizedBox(width: 6,),
                          Text(
                            savedNewsModel.estimatedFinishTime
                                .toString() +
                                " phút đọc",style: TextStyle(fontSize: 15, color: LIGHT_DARK_GREY_COLOR),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget GuidebookItem(context, SavedGuidebookModel savedGuidebookModel) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuidebookDetail(savedGuidebookModel),
          ));
    },
    child: Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: savedGuidebookModel.imageURL,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 90,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          savedGuidebookModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Text(
                              DateTimeConvert.convertDatetimeDMY(
                                  savedGuidebookModel.createTime),
                              style: TextStyle(fontSize: 15.0, color: LIGHT_DARK_GREY_COLOR)),
                          SizedBox(width: 6,),
                          Icon(
                            Icons.fiber_manual_record,
                            color: GREY_COLOR,
                            size: 6,
                          ),
                          SizedBox(width: 6,),
                          Text(
                            savedGuidebookModel.estimatedFinishTime
                                .toString() +
                                " phút đọc",style: TextStyle(fontSize: 15, color: LIGHT_DARK_GREY_COLOR),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
