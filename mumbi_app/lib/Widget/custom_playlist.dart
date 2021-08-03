import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

Widget customActivity({String icon, String title, Widget widget}){
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: GREY_COLOR, spreadRadius: 0, blurRadius: 5),
        ],
      ),
      child: Column(
        children: <Widget>[
          ExpansionTile(
            leading: IconButton(
              icon: SvgPicture.asset(icon), onPressed: null,
            ),
            title: Text(title, style: TextStyle(fontSize: 18)),
            trailing:Icon(
              Icons.keyboard_arrow_down,
            ),
            children: [
              widget
            ],
          ),
        ],
      ),
    ),
  );
}
Widget customListTilePlaylist(String _name,String _icon,{Function onClick}){
  return GestureDetector(
    onTap: onClick,
    child: Card(
      elevation: 0,
      child: ListTile(
        title: Text(_name),
        leading: IconButton(
          icon: SvgPicture.asset(_icon), onPressed: null,
        ),
      ),
    ),
  );
}



