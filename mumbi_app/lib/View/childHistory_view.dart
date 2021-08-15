import 'package:flutter/material.dart';

class ChildHistory extends StatefulWidget {
  @override
  _ChildHistoryState createState() => _ChildHistoryState();
}

class _ChildHistoryState extends State<ChildHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử thông tin"),
      ),
      body: Center(
        child: Text("..."),
      ),
    );
  }
}
