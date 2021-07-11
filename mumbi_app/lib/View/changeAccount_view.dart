import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Widget/createList.dart';


class ChangeAccount extends StatefulWidget {

  @override
  _ChangeAccountState createState() => _ChangeAccountState();
}

class _ChangeAccountState extends State<ChangeAccount> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chuyển thành viên"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListTileSelectedAccount(context, motherImage, "Nguyễn Thị Bé Nhỏ", "Đang Chọn"),
            SizedBox(height: 10,),
            createListTileUnselectedAccount(context, fatherImage, "Nguyễn Văn Jennie", "Cha"),
            SizedBox(height: 10,),
            createListTileUnselectedAccount(context, hinhcon, "Nguyễn Thị Lisa", "Con"),
          ],
        ),
      ),
    );
  }
}
