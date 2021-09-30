import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/news_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetail extends StatefulWidget {
  final model;

  const NewsDetail(this.model);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool SavedFlag;
  num SavedID;
  NewsViewModel newsTypeViewModel;

  @override
  void initState() {
    super.initState();
    newsTypeViewModel = new NewsViewModel();
    newsTypeViewModel.getNewsByType(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text("Tin tức"),
          actions: [
            MoreButton(),
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

  Widget MoreButton() {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            showModalBottom();
          },
          child: Icon(Icons.more_vert),
        ));
  }

  Future<dynamic> showModalBottom() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SaveFunction(),
            ],
          );
        });
  }

  Widget SaveFunction() {
    return ScopedModel(
        model: SavedNewsViewModel.getInstance(),
        child: ScopedModelDescendant(
          builder: (context, Widget child, SavedNewsViewModel model) {
            model.getSavedNewsByMom();
            SavedFlag = false;
            if (model.savedNewsListModel != null) {
              for (int i = 0; i < model.savedNewsListModel.length; i++) {
                SavedNewsModel savedNewsModel = model.savedNewsListModel[i];
                if (savedNewsModel.newsId == widget.model.newsId) {
                  SavedFlag = true;
                  SavedID = savedNewsModel.id;
                  break;
                }
              }
            }
            return ListTile(
              leading: Icon(
                SavedFlag == true
                    ? Icons.bookmark_remove_outlined
                    : Icons.bookmark_add_outlined,
                color: BLACK_COLOR,
              ),
              title:
                  Text(SavedFlag == true ? 'Bỏ lưu bài viết' : "Lưu bài viết"),
              onTap: () async {
                showProgressDialogue(context);
                bool result = false;
                if (SavedFlag == true) {
                  result = await SavedNewsViewModel().unsavedNews(SavedID);
                } else {
                  result =
                      await SavedNewsViewModel().saveNews(widget.model.newsId);
                }
                Navigator.pop(context);
                Navigator.pop(context);
                if (result) {
                  getFlushBar(
                      context,
                      SavedFlag == true
                          ? "Đã bỏ lưu bài viết"
                          : "Đã lưu bài viết");
                } else {
                  getFlushBar(context, ERROR_MESSAGE);
                }
                setState(() {});
              },
            );
          },
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
                      NewsDetail(newsModel));
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
}
