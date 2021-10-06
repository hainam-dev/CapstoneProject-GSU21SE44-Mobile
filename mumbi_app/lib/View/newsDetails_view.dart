import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  NewsViewModel newsTypeViewModel;
  SavedNewsViewModel savedNewsViewModel;

  @override
  void initState() {
    super.initState();
    newsTypeViewModel = new NewsViewModel();
    newsTypeViewModel.getNewsByType(widget.model.typeId, widget.model.newsId);

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
              SizedBox(
                height: 15,
              ),
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
        "Bài viết cùng chủ đề",
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
      model: newsTypeViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            NewsViewModel model) {
          return model.loadingNewsListModel == true
              ? loadingProgress()
              : model.newsListModel == null
              ? SizedBox.shrink()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RelatedPost(),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayCurve:
                  Curves.fastLinearToSlowEaseIn,
                  viewportFraction: 1,
                ),
                itemCount: model.newsListModel.length,
                itemBuilder: (context, index, realIndex) {
                  NewsModel newsModel =
                  model.newsListModel[index];
                  return createNewsItem(
                      newsModel.imageURL,
                      newsModel.title,
                      newsModel.estimatedFinishTime
                          .toString(),
                      NewsDetail(newsModel,NORMAL_ENTRY));
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget createNewsItem(
      String _imageURL, String _title, String _estimatedTime, Widget _screen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
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
            extendBody: true,
            body: Ink.image(
              image: CachedNetworkImageProvider(
                _imageURL,
              ),
              fit: BoxFit.cover,
            ),
            bottomNavigationBar: Container(
              color: BLACK_COLOR.withOpacity(0.7),
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
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: WHITE_COLOR),
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
                                height: 16, width: 16, color: WHITE_COLOR)),
                        SizedBox(width: 5),
                        Text(
                          _estimatedTime + " phút đọc",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: WHITE_COLOR),
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
