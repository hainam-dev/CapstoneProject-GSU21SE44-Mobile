import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

class PhoneEmpty extends StatefulWidget {
  const PhoneEmpty({Key key}) : super(key: key);

  @override
  _PhoneEmptyState createState() => _PhoneEmptyState();
}

class _PhoneEmptyState extends State<PhoneEmpty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch Tiêm chủng"),
        leading: backButton(context,InjectionSchedule()),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(emptyPhone),
              Text("Số điện thoại của bạn chưa có trong dữ liệu")
            ],
          ),
        ),
      ),
    );
  }
}
