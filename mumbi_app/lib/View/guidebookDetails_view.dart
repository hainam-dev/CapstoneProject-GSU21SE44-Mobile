import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/savedGuidebook_viewmodel.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookDetail extends StatefulWidget {
  final model;
  final entry;

  const GuidebookDetail(this.model, this.entry);

  @override
  _GuidebookDetailState createState() => _GuidebookDetailState();
}

class _GuidebookDetailState extends State<GuidebookDetail> {
  bool unsavedFlag = false;
  SavedGuidebookViewModel savedGuidebookViewModel;

  @override
  void initState() {
    super.initState();
    savedGuidebookViewModel = new SavedGuidebookViewModel();
    savedGuidebookViewModel.checkSavedGuidebook(widget.model.guidebookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text("Cẩm nang"),
          actions: [
            SaveFunction(),
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


  Widget Thumbnail() {
    return Center(
      child: Ink.image(
        image: CachedNetworkImageProvider(widget.model.imageURL,),height: 300,fit: BoxFit.cover,),
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
        data: widget.model.guidebookContent,
      ),
    );
  }

  Widget SaveFunction(){
    return ScopedModel(
        model: savedGuidebookViewModel,
        child: ScopedModelDescendant(builder: (BuildContext context, Widget child, SavedGuidebookViewModel model) {
          return model.isLoading == true
              ? loadingCheckSaved()
              : IconButton(
            icon: Icon(model.savedGuidebookModel.id == 0
                ? Icons.bookmark_border_outlined
                : Icons.bookmark ,size: 28,),
            onPressed: () async {
              bool result;
              if(model.savedGuidebookModel.id == 0){
                result = await SavedGuidebookViewModel().saveGuidebook(widget.model.guidebookId);
              }else{
                result = await SavedGuidebookViewModel().unsavedGuidebook(model.savedGuidebookModel);
                if(widget.entry == SAVED_ENTRY){
                  removeItem(context);
                }
              }
              if (result) {
                getFlushBar(context, model.savedGuidebookModel.id == 0 ? SAVED_GUIDEBOOK_MESSAGE : UNSAVED_GUIDEBOOK_MESSAGE);
              } else {
                getFlushBar(context, ERROR_MESSAGE);
              }
              savedGuidebookViewModel.checkSavedGuidebook(widget.model.guidebookId);
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
