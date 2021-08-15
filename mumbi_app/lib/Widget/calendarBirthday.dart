import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/Variable.dart';
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
        firstDate: getFirstDate(title),
        lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('GetBirthday', _dateController.text);
    }
    widget.function;
  }

  DateTime getFirstDate(String title){
    switch (title){
      case PARENT_BIRTHDAY_FIELD : return DateTime.now().subtract(new Duration(days: MAX_BIRTHDAY_PARENT));
      case CHILD_BIRTHDAY_FIELD : return DateTime.now().subtract(new Duration(days: MAX_BIRTHDAY_CHILD));
      case FIRST_DAY_OF_LAST_PERIOD_FIELD: return DateTime.now().subtract(new Duration(days: PREGNANCY_DAY - 8));
      default : return DateTime.now();
    }
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 6),
            child: TextFormField(
              onSaved: (val) {
                _date.date = selectedDate;
              },
              controller: _dateController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: PINK_COLOR),
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
      ),
    );
  }
}
