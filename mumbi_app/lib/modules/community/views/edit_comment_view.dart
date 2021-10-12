import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/modules/community/viewmodel/comment_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/mom_viewmodel.dart';
import 'package:mumbi_app/widgets/customProgressDialog.dart';

class EditComment extends StatefulWidget {
  final commentModel;

  const EditComment(this.commentModel);

  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {

  MomViewModel momViewModel;
  bool editFlag = true;
  String newContent;

  @override
  void initState() {
    super.initState();
    newContent = widget.commentModel.commentContent;
    momViewModel = MomViewModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sửa bình luận",
        ),
        actions: [
          EditButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommentContent(),
          ],
        ),
      ),
    );
  }

  Widget CommentContent(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.commentModel.commentContent,
              minLines: 1,
              maxLines: null,
              autofocus: true,
              enabled: true,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: "Nội dung bình luận...",
                focusColor: LIGHT_PINK_COLOR,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  if (value != "") {
                    newContent = value;
                    editFlag = true;
                  } else {
                    newContent = "";
                    editFlag = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget EditButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
      child: FlatButton(
        color: editFlag == true ? WHITE_COLOR : LIGHT_GREY_COLOR,
        splashColor: editFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        focusColor: editFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        highlightColor:
        editFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () async {
          editFlag == true ? handlePost() : null;
        },
        child: Text(
          "Lưu",
          style: TextStyle(
            color: editFlag == true ? PINK_COLOR : GREY_COLOR,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void handlePost() async {
    showProgressDialogue(context);
    bool result = false;
    widget.commentModel.commentContent = newContent;
    result = await CommentViewModel().updateComment(widget.commentModel);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
