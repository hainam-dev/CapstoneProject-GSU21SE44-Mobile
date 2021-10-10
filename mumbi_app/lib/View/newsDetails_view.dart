import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/news_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/Widget/customCard.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetail extends StatefulWidget {
  final model;
  final entry;

  const NewsDetail(this.model, this.entry);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool unsavedFlag = false;
  NewsViewModel relatedNewsViewModel;
  SavedNewsViewModel savedNewsViewModel;

  @override
  void initState() {
    super.initState();
    relatedNewsViewModel = new NewsViewModel();
    relatedNewsViewModel.getRelatedNews(widget.model.typeId, widget.model.newsId);

    savedNewsViewModel = new SavedNewsViewModel();
    savedNewsViewModel.checkSavedNews(widget.model.newsId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text("Tin tức"),
          actions: [
            SaveFunction(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Thumbnail(),
              Type(),
              Title(),
              CreateAndReadTime(),
              Content(),
              RelatedPostContainer(),
            ],
          ),
        ));
  }

  Widget Thumbnail() {
    return Center(
      child: Ink.image(
        image: CachedNetworkImageProvider(
          widget.model.imageURL,
        ),
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget Type() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 10, 0),
      child: Text(
        widget.model.typeName,
        style: TextStyle(
            fontSize: 12, color: LIGHT_DARK_GREY_COLOR.withOpacity(0.7)),
      ),
    );
  }

  Widget Title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 10, 8),
      child: Text(
        widget.model.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget RelatedPost() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 10, 8),
      child: Text(
        "Tin tức liên quan",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: PINK_COLOR),
      ),
    );
  }

  Widget CreateAndReadTime() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(
          children: [
            Text(
              DateTimeConvert.timeAgoSinceDateWithDoW(widget.model.createTime),
              style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
            ),
            SizedBox(width: 6),
            Icon(
              Icons.fiber_manual_record,
              color: GREY_COLOR,
              size: 6,
            ),
            SizedBox(width: 6),
            Text(
              widget.model.estimatedFinishTime.toString() + " phút đọc",
              style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
            ),
          ],
        ));
  }

  Widget Content() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Html(
        data: widget.model.newsContent,
      ),
    );
  }

  Widget RelatedPostContainer(){
    return ScopedModel(
      model: relatedNewsViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            NewsViewModel model) {
          return model.isLoading == true
              ? loadingProgress()
              : model.newsListModel == null
              ? SizedBox.shrink()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RelatedPost(),
              for(var newsModel in model.newsListModel)
              NormalCardItem(newsModel.imageURL, newsModel.title, newsModel.createTime, newsModel.estimatedFinishTime,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(newsModel, NORMAL_ENTRY),));
              }),
            ],
          );
        },
      ),
    );
  }

  Widget SaveFunction(){
    return ScopedModel(
      model: savedNewsViewModel,
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, SavedNewsViewModel model) {
        return model.isLoading == true
            ? loadingCheckSaved()
            : IconButton(
              icon: Icon(model.savedNewsModel.id == 0
                  ? Icons.bookmark_border_outlined
                  : Icons.bookmark ,size: 28,),
              onPressed: () async {
                bool result;
                if(model.savedNewsModel.id == 0){
                  result = await SavedNewsViewModel().saveNews(widget.model.newsId);
                }else{
                  result = await SavedNewsViewModel().unsavedNews(model.savedNewsModel.id);
                  if(widget.entry == SAVED_ENTRY){
                    removeItem(context);
                  }
                }
                if (result) {
                  getFlushBar(context, model.savedNewsModel.id == 0 ? SAVED_NEWS_MESSAGE : UNSAVED_NEWS_MESSAGE);
                } else {
                  getFlushBar(context, ERROR_MESSAGE);
                }
                savedNewsViewModel.checkSavedNews(widget.model.newsId);
          },
        );
      },)
    );
  }

  void removeItem(BuildContext context) {
    unsavedFlag = true;
    Navigator.pop(context, unsavedFlag);
  }
}
