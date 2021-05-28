import 'package:flutter/material.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("Gia Đình Của Tôi", style: TextStyle(fontSize: 40),),
      )
    );
  }
}
