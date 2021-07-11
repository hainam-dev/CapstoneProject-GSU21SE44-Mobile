import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';

class CalculateDate extends StatefulWidget {
  @override
  _CalculateDateState createState() => _CalculateDateState();
}

enum ListRadio { btn1, btn2 }

class _CalculateDateState extends State<CalculateDate> {
  ListRadio _site = ListRadio.btn1;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: Text(
          'Tính ngày dự sinh',
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCalendarImage(),
              Container(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Text(
                  'Mẹ ơi! Hãy nhập những thông tin dưới đây để biết được ngày con chào đời nhé.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              CalendarBirthday('Chọn ngày đầu tiên của kì kinh nguyệt cuối',""),
              SizedBox(
                height: 24.0,
              ),
              _typePeriod(),
              SizedBox(
                height: 24.0,
              ),
              _chooseRadioBtn(),
              SizedBox(
                height: 152.0,
              ),
              _btnSave()
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnSave() => Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 60,
        child: new RaisedButton(
          child: new Text(
            "Lưu thông tin",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato'),
          ),
          textColor: Colors.white,
          color: PINK_COLOR,
          onPressed: () {
            setState(() {});
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
        ),
      );

  Widget _chooseRadioBtn() => Container(
        height: SizeConfig.blockSizeVertical * 3,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 45,
                child: ListTile(
                  title: const Text('Con so'),
                  leading: Radio<ListRadio>(
                    value: ListRadio.btn1,
                    groupValue: _site,
                    onChanged: (ListRadio value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 45,
                child: ListTile(
                  title: const Text('Con rạ'),
                  leading: Radio<ListRadio>(
                    value: ListRadio.btn2,
                    groupValue: _site,
                    onChanged: (ListRadio value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _typePeriod() => Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: PINK_COLOR, fontSize: 15.0, fontFamily: 'Lato'),
            labelText: 'Độ dài chu kì kinh nguyệt',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
            ),
          ),
          validator: (value) {
            final pattern = r'^[0-9]{2}$';
            final regExp = RegExp(pattern);
            if (value.isEmpty) {
              return 'Vui lòng nhập độ dài chu kì kinh nguyệt.';
            } else if (!regExp.hasMatch(value)) {
              return 'Chu kì kinh nguyệt không quá 100 ngày';
            } else {
              return null;
            }
          },
          onSaved: (newValue) => {},
          keyboardType: TextInputType.phone,
        ),
      );

  Widget _buildCalendarImage() => Padding(
        padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
        child: new Container(
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 50,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage(iconCalendar),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
