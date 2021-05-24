import 'package:flutter/material.dart';
import 'package:mumbi_app/Model/childrenInfo_model.dart';
import 'package:mumbi_app/Utils/constant.dart';

class CalendarCalculate extends StatefulWidget {


  @override
  _CalendarCalculateState createState() => _CalendarCalculateState();
}

class _CalendarCalculateState extends State<CalendarCalculate> {
  Date _date = new Date();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
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
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 58,
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            onSaved: (val) {
              _date.date = selectedDate;
            },
            controller: _dateController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: COLOR_THEME),
              labelText: 'Ngày dự sinh',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              suffix: Container(
                width: 109,
                height: 40,
                child: Row(
                  children: [
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    RaisedButton(
                      child: new Text(
                        "Tính ngày",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Lato',
                        ),
                      ),
                      textColor: Colors.white,
                      color: COLOR_THEME,
                      onPressed: () {
                        setState(() {});
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                    ),
                  ],
                ),
              ),
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
