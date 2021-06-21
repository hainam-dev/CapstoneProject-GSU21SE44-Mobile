import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/dateTime_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CalendarBirthday extends StatefulWidget {
  final title;
  final birthday;

  const CalendarBirthday(this.title, this.birthday);
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  @override
  void initState() {
    if(birthday != "0001-01-01T00:00:00")
      _dateController.text =
          DateFormat('dd/MM/yyyy').format(DateTime.parse(birthday));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.blockSizeHorizontal * 90,
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
