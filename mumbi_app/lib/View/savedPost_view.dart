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
import 'package:mumbi_app/Widget/customEmpty.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedPost extends StatefulWidget {
  final num tabIndex;
  const SavedPost(this.tabIndex);

  @override
  _SavedPostState createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {

  SavedNewsViewModel _savedNewsViewModel;
  SavedGuidebookViewModel _savedGuidebookViewModel;

  String SavedNewsId;
  String SavedGuidebookId;

  num _initialIndex = 0;

  @override
  void initState() {
    super.initState();
    _initialIndex = widget.tabIndex;

    _savedNewsViewModel = SavedNewsViewModel.getInstance();
    _savedNewsViewModel.getSavedNewsByMom();

    _savedGuidebookViewModel = SavedGuidebookViewModel.getInstance();
    _savedGuidebookViewModel.getSavedGuidebookByMom();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _initialIndex,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text('Bài viết đã lưu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: PINK_COLOR,
                  ),
                  labelColor: WHITE_COLOR,
                  unselectedLabelColor: BLACK_COLOR,
                  tabs: [
                    Tab(text: 'Cẩm Nang',),
                    Tab(text: 'Tin Tức',),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SavedGuidebookList(),
                  SavedNewsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SavedNewsList() {
    return ScopedModel(
        model: _savedNewsViewModel,
        child: ScopedModelDescendant(
          builder:
              (BuildContext context, Widget child, SavedNewsViewModel model) {
            return model.loadingSavedNewsListModel == true
                ? loadingProgress()
                : model.savedNewsListModel == null
                ? EmptyWithText("Chưa có tin tức được lưu")
                : Column(
              children: [
                for(var item in model.savedNewsListModel)
                  NewsItem(context, item),
              ],
            );
          },
        ));
  }

  Widget SavedGuidebookList() {
    return ScopedModel(
        model: _savedGuidebookViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child,
              SavedGuidebookViewModel model) {
            return model.loadingSavedGuidebookListModel == true
                ? loadingProgress()
                : model.savedGuidebookListModel == null
                ? EmptyWithText("Chưa có cẩm nang được lưu")
                : Column(
              children: [
                for(var item in model.savedGuidebookListModel)
                  GuidebookItem(context, item),
              ],
            );
          },
        ));
  }

  Widget NewsItem(context, SavedNewsModel savedNewsModel) {
    return GestureDetector(
      onTap: ()  async {
        Navigator.push(
            context,
            await MaterialPageRoute(
              builder: (context) => NewsDetail(savedNewsModel),
            ),
        );_savedNewsViewModel.getSavedNewsByMom();
        setState(() {});
      },
      child: Container(
        key: UniqueKey(),
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
                      imageUrl: savedNewsModel.imageURL,
                      fit: BoxFit.cover,
                      height: 75,
                      width: 100,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                                    savedNewsModel.createTime),
                                style: TextStyle(
                                    fontSize: 15.0,
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
                              savedNewsModel.estimatedFinishTime.toString() +
                                  " phút đọc",
                              style: TextStyle(
                                  fontSize: 15, color: LIGHT_DARK_GREY_COLOR),
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
      onTap: () async {
        Navigator.push(
            context,
            await MaterialPageRoute(
              builder: (context) => GuidebookDetail(savedGuidebookModel),
            ));_savedGuidebookViewModel.getSavedGuidebookByMom();
            setState(() {});
      },
      child: Container(
        key: UniqueKey(),
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
                      imageUrl: savedGuidebookModel.imageURL,
                      fit: BoxFit.cover,
                      height: 75,
                      width: 100,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                                    savedGuidebookModel.createTime),
                                style: TextStyle(
                                    fontSize: 15.0,
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
                              savedGuidebookModel.estimatedFinishTime.toString() +
                                  " phút đọc",
                              style: TextStyle(
                                  fontSize: 15, color: LIGHT_DARK_GREY_COLOR),
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
}



