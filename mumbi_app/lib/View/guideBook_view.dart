import 'package:flutter/material.dart';

class GuildBook extends StatefulWidget {
  @override
  _GuildBookState createState() => _GuildBookState();
}

class _GuildBookState extends State<GuildBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cẩm nang',style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
