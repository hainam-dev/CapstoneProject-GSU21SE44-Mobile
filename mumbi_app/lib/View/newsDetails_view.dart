import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';
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
            children: [
              Thumbnail(),
              Title(),
              CreateAndReadTime(),
              Content(),
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
                    ? Icons.bookmark_outline_rounded
                    : Icons.bookmark_outlined,
                color: BLACK_COLOR,
              ),
              title:
                  Text(SavedFlag == true ? 'Bỏ lưu bài viết' : "Lưu bài viết"),
              onTap: () async {
                bool result = false;
                if (SavedFlag == true) {
                  result = await SavedNewsViewModel().unsavedNews(SavedID);
                } else {
                  result = await SavedNewsViewModel().saveNews(widget.model.id);
                }
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
              },
            );
          },
        ));
  }

  Widget Thumbnail() {
    return Center(
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        color: BLACK_COLOR,
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: SizeConfig.blockSizeVertical * 45,
          ),
          child: Image(
              image: CachedNetworkImageProvider(
            widget.model.imageURL,
          )),
        ),
      ),
    );
  }

  Widget Title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 10, 8),
      child: Text(
        widget.model.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget CreateAndReadTime() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 10, 6),
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
      padding: const EdgeInsets.fromLTRB(10, 0, 8, 16),
      child: Html(
        data: widget.model.newsContent,
      ),
    );
  }
}
