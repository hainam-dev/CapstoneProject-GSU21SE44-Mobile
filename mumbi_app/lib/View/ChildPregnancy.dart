import 'package:flutter/material.dart';

class ChildPrenancy extends StatefulWidget {
  @override
  _ChildPrenancyState createState() => _ChildPrenancyState();
}

class _ChildPrenancyState extends State<ChildPrenancy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Text("Em bé/thai kì", style: TextStyle(fontSize: 40),),
        )
    );
  }
}
