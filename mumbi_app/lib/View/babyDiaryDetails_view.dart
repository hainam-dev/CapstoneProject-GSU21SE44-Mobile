import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/Widget/customDialog.dart';

class BabyDiaryDetails extends StatefulWidget {

  final model;

  BabyDiaryDetails(this.model);

  @override
  _BabyDiaryDetailsState createState() => _BabyDiaryDetailsState();
}

class _BabyDiaryDetailsState extends State<BabyDiaryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateTimeConvert.getDayOfWeek(widget.model.createTime)
            + DateTimeConvert.convertDatetimeFullFormat(widget.model.createTime)),
        actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Xóa nhật ký'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            if(widget.model.imageURL != null)
            getDiaryImage(widget.model.imageURL),
            Text(
              widget.model.diaryContent,
              style: TextStyle(fontSize: 16, color: LIGHT_DARK_GREY_COLOR),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Xóa nhật ký':
        bool result = false;
        result = await DiaryViewModel().deleteDiary(widget.model.id);
        Navigator.pop(context);
        showResult(context, result);
        break;
    }
  }
}

Widget getDiaryImage(String _image){
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(image: NetworkImage(_image)),
    ),
  );
}