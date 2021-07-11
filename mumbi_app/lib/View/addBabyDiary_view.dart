import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'diary_view.dart';

class AddBabyDiary extends StatefulWidget {
  @override
  _AddBabyDiaryState createState() => _AddBabyDiaryState();
}

class _AddBabyDiaryState extends State<AddBabyDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm nhật ký",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
            child: FlatButton(
              color: LIGHT_GREY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BabyDiary()));
              },
              child: Text(
                "Đăng",
                style: TextStyle(color: GREY_COLOR),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            createListTileDiaryPost(
                motherImage, "Nguyễn Thị Bé Nhỏ", "11/06/2021"),
            Card(
                color: Colors.white,
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Viết nhật ký...",
                              focusColor: LIGHT_PINK_COLOR,
                            ),
                            maxLines: 8,
                            maxLength: 2000,
                          ),
                        ],
                      ),
                    )
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Text("Thêm vào bài viết của bạn",style: TextStyle(fontWeight: FontWeight.w600),),
            trailing: Image(image: AssetImage(addImage)),
            onTap: (){},
          )
        ),
      ),
    );
  }
}
