import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customText.dart';

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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: '$appbarTitle',
          size: 20.0,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: [
            _buildChangeAvatar(),
            new Container(
              height: SizeConfig.blockSizeVertical * 60,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    _buildUsername(),
                    const SizedBox(height: 12),
                    CalendarBirthday('Ngày sinh'),
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
                    SizedBox(height: 166,),
                    _getActionButtons()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() =>
      Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: getColor),
            labelText: 'Họ & tên (*)',
            hintStyle: TextStyle(color: getColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: getColor, width: 1.0),
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

  Widget _buildPhoneNumber() =>
      Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: getColor),
            labelText: 'Số điện thoại',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: getColor, width: 1.0),
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

  Widget _buildBloodGroup(String labelText, String hinText,
      List<String> items) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 45,
        child: new DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: getColor),
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
            style: TextStyle(color: getColor),
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

  Widget _buildChangeAvatar() =>
      Padding(
        padding: EdgeInsets.only(top: 24.0, bottom: 24),
        child: new Stack(
          fit: StackFit.loose,
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: SizeConfig.blockSizeVertical * 18,
                  width: SizeConfig.blockSizeHorizontal * 40,
                  decoration: new BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(250, 101, 138, 1), width: 2),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: new ExactAssetImage(chooseImage),
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

  Widget _getActionButtons() =>
      Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: new FlatButton(
                  child: new Text("Hủy"),
                  textColor: getColor,
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
                  height: SizeConfig.blockSizeVertical * 7,
                  width: SizeConfig.blockSizeHorizontal * 65,
                  child: new RaisedButton(
                    child: new Text("Lưu thông tin"),
                    textColor: Colors.white,
                    color: getColor,
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
