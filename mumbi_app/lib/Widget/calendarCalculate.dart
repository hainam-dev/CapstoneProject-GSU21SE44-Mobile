import 'package:flutter/material.dart';
import 'package:mumbi_app/Model/childrenInfo_model.dart';
import 'package:mumbi_app/Utils/constant.dart';
import 'package:mumbi_app/View/calculateDate_view.dart';

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
      child: Row(
        children: [
          Container(
            width: 224,
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
                        color: COLOR_THEME, fontWeight: FontWeight.w600),
                    labelText: 'Ngày dự sinh',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
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
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 109,
            height: 58,
            child: RaisedButton(
              child: new Text(
                "Tính ngày",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,fontWeight: FontWeight.w700,
                  fontFamily: 'Lato',
                ),
              ),
              textColor: Colors.white,
              color: COLOR_THEME,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalculateDate()));
                setState(() {});
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
            ),
          )
        ],
      ),
    );
  }
}
