import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Model/childrenInfo_model.dart';
import 'package:mumbi_app/Utils/constant.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';

class ChildrenInfo extends StatefulWidget {
  @override
  _ParentInfoState createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ChildrenInfo> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String dateOfBirth = '';
  String phoneNumber = '';
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1125, 2436),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 48,
        title: Text(
          'Thêm bé/thai kì',
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
      ),
      body: Container(
        height: 2344,
        width: 1125,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildChangeAvatar(),
              new Container(
                height: 552,
                width: 343,
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 5),
                      _buildUsername('Họ & tên (*)'),
                      const SizedBox(height: 12),
                      _buildUsername('Tên ở nhà'),
                      const SizedBox(height: 12),
                      _buildStatus(),
                      const SizedBox(height: 12),
                      (selectedValue.toString() == "Bé đã sinh")
                          ? CalendarBirthday('Ngày sinh')
                          : (selectedValue.toString() == "Thai nhi")
                              ? CalendarCalculate()
                              : CalendarBirthday('Ngày sinh'),
                      const SizedBox(height: 12),
                      _buildGender(),
                      const SizedBox(height: 88),
                      _getActionButtons()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsername(String name) => Container(
        height: 58,
        child: TextFormField(
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w100),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: name,
            hintStyle: TextStyle(color: COLOR_THEME),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: COLOR_THEME, width: 1.0),
            ),
          ),
          validator: (value) {
            if (value.length < 4) {
              return 'Enter at least 4 characters';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => username = value),
          keyboardType: TextInputType.name,
        ),
      );

  Widget _buildStatus() => Container(
        height: 60,
        width: 163,
        child: new DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: 'Trạng thái(*)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          hint: Text(
            'Trạng thái(*)',
            style: TextStyle(color: COLOR_THEME),
          ),
          items: [
            DropdownMenuItem(
              value: 'Thai nhi',
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    IMAGE + 'icon_child.png',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Text(
                      'Thai nhi',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Lato'),
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Bé đã sinh',
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    IMAGE + 'icon_child.png',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Text(
                      'Bé đã sinh',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Lato'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (value) async {
            print(selectedValue = value);
            await setState(() {
              _ParentInfoState();
            });
          },
          // value: _value,
          isExpanded: true,
        ),
      );

  Widget _buildGender() => Container(
        height: 60,
        width: 163,
        child: new DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: 'Giới tính(*)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          hint: Text(
            'Giới tính(*)',
            style: TextStyle(color: COLOR_THEME),
          ),
          items: [
            DropdownMenuItem(
              value: 'Bé trai',
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    IMAGE + 'icon_boy.png',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Text(
                      'Bé trai',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Lato'),
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Bé gái',
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    IMAGE + 'icon_girl.png',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Text(
                      'Bé gái',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Lato'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (value) {},
          // value: _value,
          isExpanded: true,
        ),
      );

  Widget _buildChangeAvatar() => Padding(
        padding: EdgeInsets.only(top: 24.0, bottom: 24),
        child: new Stack(
          fit: StackFit.loose,
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: new BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(250, 101, 138, 1), width: 2),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: new ExactAssetImage(IMAGE + 'Image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.0, left: 100.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor: Color.fromRGBO(251, 103, 139, 1),
                    radius: 16.0,
                    child: new Icon(
                      Icons.image_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _getActionButtons() => Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Container(
                width: 120,
                height: 50,
                child: new FlatButton(
                  child: new Text("Hủy"),
                  textColor: COLOR_THEME,
                  onPressed: () {
                    setState(() {});
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Container(
                  width: 207,
                  height: 50,
                  child: new RaisedButton(
                    child: new Text("Lưu thông tin"),
                    textColor: Colors.white,
                    color: COLOR_THEME,
                    onPressed: () {
                      setState(() {});
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                  )),
              flex: 2,
            ),
          ],
        ),
      );
}
