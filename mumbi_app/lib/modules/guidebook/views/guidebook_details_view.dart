import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/modules/guidebook/viewmodel/guidebook_viewmodel.dart';
import 'package:mumbi_app/modules/guidebook/viewmodel/saved_guidebook_viewmodel.dart';
import 'package:mumbi_app/widgets/customCard.dart';
import 'package:mumbi_app/widgets/customFlushBar.dart';
import 'package:mumbi_app/widgets/customLoading.dart';

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
  GuidebookViewModel relatedGuidebookViewModel;
  SavedGuidebookViewModel savedGuidebookViewModel;

  @override
  void initState() {
    super.initState();
    relatedGuidebookViewModel = new GuidebookViewModel();
    relatedGuidebookViewModel.getRelatedGuidebook(
        widget.model.typeId, widget.model.guidebookId);

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
        style: {
          "body": Style(
            fontSize: FontSize(16.0),
          ),
        },
      ),
    );
  }

  Widget RelatedPost() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 10, 8),
      child: Text(
        "Cẩm nang liên quan",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: PINK_COLOR),
      ),
    );
  }

  Widget RelatedPostContainer() {
    return ScopedModel(
      model: relatedGuidebookViewModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, GuidebookViewModel model) {
          return model.isLoading == true
              ? loadingProgress()
              : model.guidebookListModel == null
                  ? SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RelatedPost(),
                        for (var guidebookModel in model.guidebookListModel)
                          NormalCardItem(
                              guidebookModel.imageURL,
                              guidebookModel.title,
                              guidebookModel.createTime,
                              guidebookModel.estimatedFinishTime, onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GuidebookDetail(
                                      guidebookModel, NORMAL_ENTRY),
                                ));
                          }),
                      ],
                    );
        },
      ),
    );
  }

  Widget SaveFunction() {
    return ScopedModel(
        model: savedGuidebookViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child,
              SavedGuidebookViewModel model) {
            return model.isLoading == true
                ? loadingCheckSaved()
                : IconButton(
                    icon: Icon(
                      model.savedGuidebookModel.id == 0
                          ? Icons.bookmark_border_outlined
                          : Icons.bookmark,
                      size: 28,
                    ),
                    onPressed: () async {
                      bool result;
                      if (model.savedGuidebookModel.id == 0) {
                        result = await SavedGuidebookViewModel()
                            .saveGuidebook(widget.model.guidebookId);
                      } else {
                        result = await SavedGuidebookViewModel()
                            .unsavedGuidebook(model.savedGuidebookModel);
                        if (widget.entry == SAVED_ENTRY) {
                          removeItem(context);
                        }
                      }
                      if (result) {
                        getFlushBar(
                            context,
                            model.savedGuidebookModel.id == 0
                                ? SAVED_GUIDEBOOK_MESSAGE
                                : UNSAVED_GUIDEBOOK_MESSAGE);
                      } else {
                        getFlushBar(context, ERROR_MESSAGE);
                      }
                      savedGuidebookViewModel
                          .checkSavedGuidebook(widget.model.guidebookId);
                    },
                  );
          },
        ));
  }

  void removeItem(BuildContext context) {
    unsavedFlag = true;
    Navigator.pop(context, unsavedFlag);
  }
}
