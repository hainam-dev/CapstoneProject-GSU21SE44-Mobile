import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Widget/createList.dart';

import 'addBabyDiary_view.dart';


class BabyDiary extends StatefulWidget {
  @override
  _BabyDiaryState createState() => _BabyDiaryState();
}

class _BabyDiaryState extends State<BabyDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhật ký"),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
        children: [
          //createEmptyDiary(context),
          createDiaryItem(context, "06/05/2021",
              "Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời."),
          SizedBox(height: 10,),
          createDiaryItem(context, "06/05/2021","Trẻ em như búp trên cành, biết ăn biết ngủ biết học hành là ngoan"),
          SizedBox(height: 10,),
          createDiaryItem(context, "06/05/2021",
              "Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời."),
          SizedBox(height: 10,),
          createDiaryItem(context, "06/05/2021"," Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời."),
          SizedBox(height: 10,),
          createDiaryItem(context, "06/05/2021",
              "Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời."),
          SizedBox(height: 10,),
          createDiaryItem(context, "06/05/2021",
              "Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời."),
          SizedBox(height: 10,),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBabyDiary()));
        },
        label: Text('Thêm nhật ký'),
        icon: Image.asset(
          addDiary,
        ),
        backgroundColor: PINK_COLOR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


