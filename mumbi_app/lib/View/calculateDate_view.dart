import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';

class CalculateDate extends StatefulWidget {
  @override
  _CalculateDateState createState() => _CalculateDateState();
}

enum ListRadio { btn1, btn2 }

class _CalculateDateState extends State<CalculateDate> {
  ListRadio _site = ListRadio.btn1;
  DateTime FirstDayOfLastPeriod;
  DateTime EstimatedBornDate;
  String result;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tính ngày dự sinh',
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _buildCalendarImage(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Mẹ ơi! Hãy nhập những thông tin dưới đây để biết được ngày con chào đời nhé.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                CalendarBirthday(FIRST_DAY_OF_LAST_PERIOD_FIELD,"",
                  function: (value) {
                    if (value.isEmpty) {
                      return "Vui lòng chọn ngày đầu tiên của kì kinh nguyệt cuối";
                    } else {
                      setState(() {
                        FirstDayOfLastPeriod = DateTimeConvert.convertStringToDatetimeDMY(value);
                      });
                    }
                  },),
                _chooseRadioBtn(),
                if(_site == ListRadio.btn1)
                  Text("(Con so có thể sinh sớm hơn con rạ 8 ngày)",style: TextStyle(fontStyle: FontStyle.italic),),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  Widget _btnSave() => GestureDetector(
    onTap: (){
      if (formKey.currentState.validate()) {
        if(_site == ListRadio.btn1){
          EstimatedBornDate = FirstDayOfLastPeriod.add(new Duration(days: PREGNANCY_DAY)).subtract(new Duration(days: 8));
        }else{
          EstimatedBornDate = FirstDayOfLastPeriod.add(new Duration(days: PREGNANCY_DAY));
        }
        result = DateTimeConvert.convertDateTimeToStringDMY(EstimatedBornDate);
        Navigator.pop(context, result);
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 120,vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: PINK_COLOR,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          "Tính ngày",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: WHITE_COLOR,
              fontSize: 20),
        ),
      ),
    ),
  );

  Widget _chooseRadioBtn() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      GestureDetector(
        onTap: (){
          setState(() {
            _site = ListRadio.btn1;
          });
        },
        child: Row(
          children: [
            Radio<ListRadio>(
              value: ListRadio.btn1,
              groupValue: _site,
              onChanged: (ListRadio value) {
                setState(() {
                  _site = value;
                });
              },
            ),
            Text('Con so'),
          ],
        ),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            _site = ListRadio.btn2;
          });
        },
        child: Row(
          children: [
            Radio<ListRadio>(
              value: ListRadio.btn2,
              groupValue: _site,
              onChanged: (ListRadio value) {
                setState(() {
                  _site = value;
                });
              },
            ),
            Text('Con rạ'),
          ],
        ),
      ),
    ],
  );

  Widget _buildCalendarImage() => SvgPicture.asset(iconCalendar,width: 200,height: 200,);
}
