import 'dart:ffi';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mumbi_app/Model/playlist_model.dart';
import 'package:mumbi_app/View/example.dart';
import 'package:mumbi_app/Constant/textStyle.dart';

Widget createTextFeild(String title){
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, top: 12),
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title
      ),
    ),
  );
}
Widget createButtonConfirm(String title){
return SingleChildScrollView(
  child:   Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    child: SizedBox(
      width: 190,
      height: 50,
      child: ElevatedButton(onPressed: () => {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )
            )
        ),
        child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ),
    ),
  ),
);
}

Widget createButtonCancel(BuildContext context,String title, Widget _screen){
  return SizedBox(
    width: 120,
    height: 50,
    child: RaisedButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _screen),
          )
        },
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
    ),
  );
}

Widget createListTile(String name){
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon( Icons.assignment_ind_sharp)),
      title: Text(name),
      onTap: () => {},
    ),
  );
}

Widget createListTileDetail(String name, String detail){
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon( Icons.assignment_ind_sharp)),
      subtitle: Text(name),
      title: Text(detail),
      onTap: () => {},
      trailing: Icon( Icons.keyboard_arrow_down_outlined),
    ),
  );
}

Widget createListTileNext(String name, String detail){
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: new BoxDecoration(
      color: LIGHT_BLUE_COLOR,
    ),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: SvgPicture.asset(ic_needle)),
      subtitle: Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      title: Text(detail,),
      onTap: () => {},
      trailing: Icon( Icons.navigate_next),
    ),
  );
}

Widget createListOption(int value, onChange){
  int _value = 1;
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon( Icons.assignment_ind_sharp)),
        Text('bé bông'
        ),
        DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("First Item"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Second Item"),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Text("Third Item"),
                  value: 3
              ),
              DropdownMenuItem(
                  child: Text("Fourth Item"),
                  value: 4
              )
            ],
            onChanged: onChange
            ),

      ]
    ),
  );
}

Widget createDataWithIcon(String name){
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon( Icons.assignment_ind_sharp)),
        Text(name),
      ],
    ),
  );
}

Widget createData(String name){
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Text(name),
  );
}

Widget createFlatButton(BuildContext context, String _title, Widget _screen){
  return FlatButton(
    onPressed: () =>{
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => _screen),)
    },
    color: Colors.white,
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.pinkAccent),
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child:Text(_title,style: TextStyle(
      color: Colors.pinkAccent,fontSize: 14, fontWeight: FontWeight.w600,
    ),),
  );
}

Widget createLinear(String _name,double _value,Color _color){
  return Container(
    padding: EdgeInsets.only(top:16,),
    child: Row(
      children: <Widget>[
        Container(
          width: 100,
            child: Text(_name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              minHeight: 16,
              value: _value,
              // semanticsValue:"Percent " + (_value * 100).toString() + "%",
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(_color),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            (_value * 100).round().toString()+ "%",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
  );
}

Widget createButtonWhite(BuildContext context,String title, double _width,Widget screen){
  return SizedBox(
    width: _width,
    height: 50,
    child: RaisedButton(
        onPressed: () =>
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          )
        },
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Text(title, style: BOLDPINK_16,),
    ),
  );
}

Widget getButtonUpload(BuildContext context){
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      decoration: new BoxDecoration(
        color: GREY_100,
      ),
      child: SizedBox(
        width: 80,
        height: 80,
        child: DottedBorder(
          strokeCap: StrokeCap.butt,
          color: GREY_COLOR_LIGHT,
          // gap: 3,
          strokeWidth: 1,
          child: Center(
              child: FlatButton(
                child: SvgPicture.asset(btn_plus),
              )),
        ),
      ),
    ),
  );
}

Widget createTeeth(String icon, String iconChoose, bool choose){
  return Positioned(
    height: 85, width: 85,top: 100, left: -2,
    child: Container(
      child: IconButton(
        icon: SvgPicture.asset(choose ? iconChoose : icon  ),
        // onPressed: ontap,
      ),
    ),
  );
}

