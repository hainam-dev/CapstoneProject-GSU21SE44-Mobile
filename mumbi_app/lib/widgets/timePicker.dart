import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String _setTime;

  String _hour, _minute, _time;

  String dateTime;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();
  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primarySwatch: ColorTheme,
              primaryColor: ColorTheme,
              // Picked or select date color
              accentColor: ColorTheme, // Picked or select date color
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  // @override
  // void initState() {
  //   _timeController.text = formatDate(
  //       DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
  //       [hh, ':', nn, " ", am]).toString();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.blockSizeHorizontal * 90,
      child: GestureDetector(
        onTap: () => _selectedTime(context),
        child: AbsorbPointer(
          child: TextFormField(
            onSaved: (val) {
              _setTime = val;
            },
            controller: _timeController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: PINK_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0),
              prefixIcon: Icon(
                Icons.add,
                color: PINK_COLOR,
              ),
              labelText: 'Thêm nhắc nhở',
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            validator: (value) {
              if (value.isEmpty) return "Please enter a date";
              return null;
            },
          ),
        ),
      ),
    );
  }
}
