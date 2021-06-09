import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mumbi_app/View/example.dart';

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
return Container(
  padding: EdgeInsets.only(left: 16, right: 16),
  child: SizedBox(
    width: 205,
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
);
}

Widget createButtonCancel(String title){
  return SizedBox(
    width: 120,
    height: 50,
    child: RaisedButton(onPressed: () => {},
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
      trailing: Icon( Icons.keyboard_arrow_down_outlined),
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

// Widget createDataMenuItem(String name,int i){
//   return DropdownMenuItem(
//     child: createData(name),
//     value: i,
//   );
// }