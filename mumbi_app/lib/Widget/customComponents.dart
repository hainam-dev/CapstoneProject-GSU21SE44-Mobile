import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

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

Widget createFamilyCard(BuildContext context, String _imageURL, String _name, Color _labelColor, String _labelText , Color _labelTextColor, Widget _screen){
  return Container(
    height: SizeConfig.blockSizeVertical * 22,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: RaisedButton(
        color: WHITE_COLOR,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          height: SizeConfig.safeBlockVertical * 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 39,
                    backgroundColor: PINK_COLOR,
                    backgroundImage: NetworkImage(
                        _imageURL),
                  ),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      child: SvgPicture.asset(editpencil, width: 25, height: 25,),
                      ),
                    ),
                ],
              ),
              Text(
                _name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Card(
                elevation: 0,
                color: _labelColor,
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    _labelText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: _labelTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    _screen)),
      ),
    ),
  );
}

Widget createAddFamilyCard(BuildContext context, String _title, Widget _screen){
  return Container(
    height: SizeConfig.blockSizeVertical * 22,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: RaisedButton(
        color: WHITE_COLOR,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          height: SizeConfig.safeBlockVertical * 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 39,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(empty),
              ),
              Text(
                _title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _screen)),
      ),
    ),
  );
}

// Widget createDataMenuItem(String name,int i){
//   return DropdownMenuItem(
//     child: createData(name),
//     value: i,
//   );
// }