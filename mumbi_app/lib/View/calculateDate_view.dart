import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Utils/constant.dart';
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
          'Tính ngày dự sinh',
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
      ),
      body: Container(
        height: 2344,
        width: 1125,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCalendarImage(),
              Container(
                width: 343.0,
                height: 44.0,
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
              CalendarBirthday('Chọn ngày đầu tiên của kì kinh nguyệt cuối'),
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
        width: 207,
        height: 50,
        child: new RaisedButton(
          child: new Text(
            "Lưu thông tin",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato'),
          ),
          textColor: Colors.white,
          color: COLOR_THEME,
          onPressed: () {
            setState(() {});
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
        ),
      );

  Widget _chooseRadioBtn() => Container(
        width: 343.0,
        height: 24.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 164.0,
              height: 24.0,
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
            Container(
              width: 164.0,
              height: 24.0,
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
          ],
        ),
      );

  Widget _typePeriod() => Container(
        width: 343,
        height: 58,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: COLOR_THEME, fontSize: 15.0, fontFamily: 'Lato'),
            labelText: 'Độ dài chu kì kinh nguyệt',
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
          width: 194.0,
          height: 164.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage(IMAGE + 'icon_calendar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
