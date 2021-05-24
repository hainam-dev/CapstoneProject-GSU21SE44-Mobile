import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Utils/constant.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';

class ParentInfo extends StatefulWidget {
  final appbarTitle;
  ParentInfo(this.appbarTitle);
  @override
  _ParentInfoState createState() => _ParentInfoState(this.appbarTitle);
}

class _ParentInfoState extends State<ParentInfo> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String dateOfBirth = '';
  String phoneNumber = '';
  final appbarTitle;
  _ParentInfoState(this.appbarTitle);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1125, 2436),
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: Text(
          '$appbarTitle',
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
        backgroundColor: Color.fromRGBO(251, 103, 139, 1),
      ),
      body: Container(
        color: Colors.white,
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
                      _buildUsername(),
                      const SizedBox(height: 12),
                      CalendarCalculate(),
                      const SizedBox(height: 12),
                      _buildPhoneNumber(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: _buildBloodGroup(
                                'Nhóm máu', 'Nhóm máu', ['A', 'B', 'O', 'AB']),
                            flex: 2,
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Flexible(
                            child: _buildBloodGroup('Hệ máu (Rh)',
                                'Hệ máu (Rh)', ['RH(D)+', 'RH(D)-']),
                            flex: 2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 166,
                      ),
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

  Widget _buildUsername() => Container(
        height: 58,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: 'Họ & tên (*)',
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

  Widget _buildPhoneNumber() => Container(
        height: 58,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: 'Số điện thoại',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: COLOR_THEME, width: 1.0),
            ),
          ),
          validator: (value) {
            final pattern = r'((84|0[3|5|7|8|9])+([0-9]{8})\b)';
            final regExp = RegExp(pattern);
            if (value.isEmpty) {
              return 'Vui lòng nhập số điện thoại của bạn.';
            } else if (!regExp.hasMatch(value)) {
              return 'Số điện thoại không đúng, vui lòng nhập lại!';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => phoneNumber = value),
          keyboardType: TextInputType.phone,
        ),
      );

  Widget _buildBloodGroup(
          String labelText, String hinText, List<String> items) =>
      Container(
        height: 58,
        width: 163,
        child: new DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: COLOR_THEME),
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          hint: Text(
            hinText,
            style: TextStyle(color: COLOR_THEME),
          ),
          items: items.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (_) {},
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
