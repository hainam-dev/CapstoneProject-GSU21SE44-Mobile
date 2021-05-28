import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

class BabyDiaryDetails extends StatefulWidget {
  @override
  _BabyDiaryDetailsState createState() => _BabyDiaryDetailsState();
}

class _BabyDiaryDetailsState extends State<BabyDiaryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ngày " + "06/05/2021"),
        actions: [FlatButton(
            onPressed: (){},
            child: Icon(Icons.more_horiz,color: WHITE_COLOR,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              " Những khoảng khắc đầu đời của trẻ là những khoảng khắc quý giá của những lần đầu – lần đầu khi trẻ lật, lần đầu khi trẻ bò, lần đầu khi trẻ ăn dặm và cả những bước chân chập chững đầu đời.",
              style: TextStyle(fontSize: 16, color: LIGHT_DARK_GREY_COLOR),
            ),
            SizedBox(
              height: 10,
            ),
            getDiaryImage("https://xetnghiemthanhhoa.com/wp-content/uploads/2021/04/em-be.jpg"),
            getDiaryImage("https://bacthanglong.edu.vn/wp-content/uploads/2019/09/41cb5a3266b03e4f29ecdca6f5212b22-730x430.jpg"),
          ],
        ),
      ),
    );
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