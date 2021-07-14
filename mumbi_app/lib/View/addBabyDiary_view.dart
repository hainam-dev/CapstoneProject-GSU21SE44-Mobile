import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';
import 'package:scoped_model/scoped_model.dart';

class AddBabyDiary extends StatefulWidget {
  @override
  _AddBabyDiaryState createState() => _AddBabyDiaryState();
}

class _AddBabyDiaryState extends State<AddBabyDiary> {
  DiaryModel diaryModel;
  bool postFlag;
  bool publicFlag = false;

  @override
  void initState() {
    diaryModel = DiaryModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text(
            "Thêm nhật ký",
          ),
          actions: [
            AddButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UserInfo(),
              InputPostContent(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(top: BorderSide(color: GREY_COLOR))),
          child: Card(
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChooseImageButton(),
                  PublicCommunity(),
                ],
              )),
        ),
      ),
    );
  }

  void handlePost() async {
    bool result = false;
    diaryModel.childId = "0a60af7b-754f-4b78-830c-0c551bb4ead7";
    diaryModel.publicFlag = publicFlag;
    result = await DiaryViewModel().addDiary(diaryModel);
    Navigator.pop(context);
    showResult(context, result);
  }

  Widget AddButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
      child: FlatButton(
        color: postFlag == true ? WHITE_COLOR : LIGHT_GREY_COLOR,
        splashColor:
        postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        focusColor:
        postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        highlightColor:
        postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {
          postFlag == true ? handlePost() : null;
        },
        child: Text(
          "Lưu",
          style: TextStyle(
            color: postFlag == true ? PINK_COLOR : GREY_COLOR,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget UserInfo(){
    return ScopedModel(
        model: MomViewModel.getInstance(),
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child,
              MomViewModel model) {
            model.getMomByID();
            return createListTileDiaryPost(model.momModel.imageURL,
                model.momModel.fullName, publicFlag);
          },
        ));
  }

  Widget InputPostContent() {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    autofocus: true,
                    style: TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                      hintText: "Nội dung nhật ký...",
                      focusColor: LIGHT_PINK_COLOR,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value != "") {
                          diaryModel.diaryContent = value;
                          postFlag = true;
                        } else {
                          diaryModel.diaryContent = "";
                          postFlag = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            )));
  }

  Widget ChooseImageButton() {
    return InkWell(
      onTap: () {},
      splashColor: LIGHT_PINK_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Row(
          children: [
            Icon(
              Icons.photo_library,
              color: GREEN400,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Hình ảnh",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget PublicCommunity() {
    return InkWell(
      onTap: () {
        setState(() {
          publicFlag = !publicFlag;
          if (publicFlag == true) {
            getFlushBar(context, "Cộng đồng", "Tính năng chia sẻ đã bật");
          } else {
            getFlushBar(context, "Cộng đồng", "Tính năng chia sẻ đã tắt");
          }
        });
      },
      splashColor: LIGHT_PINK_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Row(
          children: [
            Image(
              image: AssetImage(community),
              width: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Cộng Đồng",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
