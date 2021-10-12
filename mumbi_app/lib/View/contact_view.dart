import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/widgets/createList.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liên hệ hỗ trợ"),
      ),
      body: ListView(
        children: [
          createListTile(context, rule, "Điều khoản & Điều kiện"),
          createListTile(context, term, "Chính sách bảo mật và chia sẻ thông tin"),
          SizedBox(height: 15,),
          createTitleCard("Bạn cần hỗ trợ?"),
          createListTileWithBlueTextTrailing(hotline, "Hotline", "+84 1900 1560"),
          createListTileWithBlueTextTrailing(email, "Email", "support@mumbi.com"),
        ],
      ),
    );
  }
}

