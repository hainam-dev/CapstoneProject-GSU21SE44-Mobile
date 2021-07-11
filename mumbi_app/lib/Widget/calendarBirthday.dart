import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/dateTime_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarBirthday extends StatefulWidget {
  final title;
  final birthday;
  final function;
  CalendarBirthday(this.title, this.birthday, {this.function});
  @override
  _CalendarBirthdayState createState() => _CalendarBirthdayState(this.title, this.birthday);
}

class _CalendarBirthdayState extends State<CalendarBirthday> {
  Date _date = new Date();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final title;
  final birthday;
  _CalendarBirthdayState(this.title, this.birthday);
  Future<Null> _selectDate(BuildContext context) async {
    SizeConfig().init(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100),
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('GetBirthday', _dateController.text);
    }
    widget.function;
  }

  @override
  void initState() {
    super.initState();
    if(birthday != ""){
      _dateController.text = birthday;
    }else{
      _dateController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            onSaved: (val) {
              _date.date = selectedDate;
            },
            controller: _dateController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: PINK_COLOR, fontWeight: FontWeight.w600, fontSize: 14.0),
              labelText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            validator:
              widget.function
          ),
        ),
      ),
    );
  }
}
