import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/dateTime_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/calculateDate_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarCalculate extends StatefulWidget {
  final estimatedDate;
  final function;

  const CalendarCalculate(this.estimatedDate, {this.function});

  @override
  _CalendarCalculateState createState() =>
      _CalendarCalculateState(this.estimatedDate);
}

class _CalendarCalculateState extends State<CalendarCalculate> {
  Date _date = new Date();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final estimatedDate;

  _CalendarCalculateState(this.estimatedDate);

  Future<Null> _selectDate(BuildContext context) async {
    SizeConfig().init(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        currentDate: DateTime.now(),
        firstDate: DateTime.now().add(new Duration(days: 0)),
        lastDate: DateTime.now().add(new Duration(days: PREGNANCY_DAY)),
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
    if (widget.estimatedDate != "") {
      _dateController.text = estimatedDate;
    } else {
      _dateController.text = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                    onSaved: (val) {
                      _date.date = selectedDate;
                    },
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: PINK_COLOR),
                      labelText: 'Ngày dự sinh (*)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    validator: widget.function),
              ),
            ),
          ),
          SizedBox(
            width: 17,
          ),
          Flexible(
            flex: 3,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: 55.0,
              child: RaisedButton(
                child: new Text(
                  "Tính ngày",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Lato',
                  ),
                ),
                textColor: Colors.white,
                color: PINK_COLOR,
                onPressed: () {
                  _awaitReturnValueFromSecondScreen(context);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalculateDate(),
        ));
    setState(() {
      _dateController.text = result;
    });
  }
}
