import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/childHistory_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/pregnancyViewModel.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildInfoUpdate extends StatefulWidget {
  _ChildInfoUpdateState createState() => _ChildInfoUpdateState();
}

class _ChildInfoUpdateState extends State<ChildInfoUpdate> {
  final formKey = GlobalKey<FormState>();
  ChildViewModel childViewModel;
  ChildHistoryViewModel childHistoryViewModel;
  PregnancyHistoryViewModel pregnancyHistoryViewModel;

  void getChildHistory() async {
    childHistoryViewModel = ChildHistoryViewModel.getInstance();
    await childHistoryViewModel.getChildHistory(
        CurrentMember.id, DateTimeConvert.getCurrentDay());
  }

  void getPregnancyHistory() async {
    pregnancyHistoryViewModel = PregnancyHistoryViewModel.getInstance();
    await pregnancyHistoryViewModel.getPregnancyHistory(
        CurrentMember.pregnancyID, DateTimeConvert.getCurrentDay());
  }

  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();

    if (CurrentMember.pregnancyFlag == false) {
      getChildHistory();
    }

    if (CurrentMember.pregnancyFlag == true) {
      getPregnancyHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: childViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ChildViewModel model) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                onPressed: () => {Navigator.pop(context)},
              ),
              title: Text("Ngày ${DateTimeConvert.getCurrentDay()}"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DisabledTextField(
                        CurrentMember.pregnancyFlag == true
                            ? 'Tuần thai'
                            : "Tuần tuổi",
                        CurrentMember.pregnancyFlag == true
                            ? "Tuần ${DateTimeConvert.pregnancyWeek(model.childModel.estimatedBornDate)}"
                            : "Tuần ${DateTimeConvert.calculateChildWeekAge(model.childModel.birthday)}",
                      ),
                      if (CurrentMember.pregnancyFlag == true) PregnancyInfo(),
                      if (CurrentMember.pregnancyFlag == false) ChildInfo(),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomButton(
                titleCancel: 'Hủy',
                titleSave: 'Lưu thông tin',
                cancelFunction: () => {Navigator.pop(context)},
                saveFunction: () async {
                  if (formKey.currentState.validate()) {}
                }),
          );
        },
      ),
    );
  }

  Widget PregnancyInfo() {
    return ScopedModel(
      model: pregnancyHistoryViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PregnancyHistoryViewModel model) {
          return Column(
            children: [
              DigitalNumber(
                PREGNANCY_MOTHER_WEIGHT_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.motherWeight.toString(),
              ),
              DigitalNumber(
                PREGNANCY_WEIGHT_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.weight.toString(),
              ),
              DigitalNumber(
                PREGNANCY_HEAD_CIRCUMFERENCE_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.headCircumference.toString(),
              ),
              DigitalNumber(
                PREGNANCY_FETAL_HEART_RATE_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.fetalHeartRate.toString(),
              ),
              DigitalNumber(
                PREGNANCY_FEMUR_LENGTH_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.femurLength.toString(),
              ),
              DigitalNumber(
                PREGNANCY_BIPARIETAL_DIAMETER_FIELD,
                model.pregnancyHistoryModel == null
                    ? ""
                    : model.pregnancyHistoryModel.biparietalDiameter.toString(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget ChildInfo() {
    return ScopedModel(
      model: childHistoryViewModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, ChildHistoryViewModel model) {
          return Column(
            children: [
              DigitalNumber(
                CHILD_WEIGHT_FIELD,
                model.childHistoryModel == null
                    ? ""
                    : model.childHistoryModel.weight.toString(),
              ),
              DigitalNumber(
                CHILD_HEIGHT_FIELD,
                model.childHistoryModel == null
                    ? ""
                    : model.childHistoryModel.height.toString(),
              ),
              DigitalNumber(
                CHILD_HEAD_CIRCUMFERENCE_FIELD,
                model.childHistoryModel == null
                    ? ""
                    : model.childHistoryModel.headCircumference.toString(),
              ),
              DigitalNumber(
                CHILD_SLEEP_TIME_FIELD,
                model.childHistoryModel == null
                    ? ""
                    : model.childHistoryModel.hourSleep.toString(),
              ),
              DigitalNumber(
                CHILD_MILK_FIELD,
                model.childHistoryModel == null
                    ? ""
                    : model.childHistoryModel.avgMilk.toString(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget DisabledTextField(String name, String value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
        child: TextFormField(
          enabled: false,
          initialValue: value,
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w100),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: name,
            hintStyle: TextStyle(color: PINK_COLOR),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );

  Widget DigitalNumber(String title, String value, {Function onType}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
        child: TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: PINK_COLOR),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return null;
            } else if (title == CHILD_WEIGHT_FIELD &&
                !isBetween(num.parse(value), 1, 50)) {
              return CHILD_WEIGHT_VALIDATION_MESSAGE;
            } else if (title == CHILD_HEIGHT_FIELD &&
                !isBetween(num.parse(value), 25, 130)) {
              return CHILD_HEIGHT_VALIDATION_MESSAGE;
            } else if (title == CHILD_HEAD_CIRCUMFERENCE_FIELD &&
                !isBetween(num.parse(value), 25, 60)) {
              return CHILD_HEAD_CIRCUMFERENCE_VALIDATION_MESSAGE;
            } else if (title == CHILD_SLEEP_TIME_FIELD &&
                !isBetween(num.parse(value), 7, 16)) {
              return CHILD_SLEEP_TIME_VALIDATION_MESSAGE;
            } else if (title == CHILD_MILK_FIELD &&
                !isBetween(num.parse(value), 5, 1200)) {
              return CHILD_MILK_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_MOTHER_WEIGHT_FIELD &&
                !isBetween(num.parse(value), 35, 90)) {
              return PREGNANCY_MOTHER_WEIGHT_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_WEIGHT_FIELD &&
                !isBetween(num.parse(value), 0.1, 3.5)) {
              return PREGNANCY_WEIGHT_FIELD_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_HEAD_CIRCUMFERENCE_FIELD &&
                !isBetween(num.parse(value), 60, 350)) {
              return PREGNANCY_HEAD_CIRCUMFERENCE_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_FETAL_HEART_RATE_FIELD &&
                !isBetween(num.parse(value), 100, 190)) {
              return PREGNANCY_FETAL_HEART_RATE_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_FEMUR_LENGTH_FIELD &&
                !isBetween(num.parse(value), 13, 84)) {
              return PREGNANCY_FEMUR_LENGTH_VALIDATION_MESSAGE;
            } else if (title == PREGNANCY_BIPARIETAL_DIAMETER_FIELD &&
                !isBetween(num.parse(value), 21, 94)) {
              return PREGNANCY_BIPARIETAL_DIAMETER_VALIDATION_MESSAGE;
            } else {
              return null;
            }
          },
          onChanged: onType,
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            TextInputFormatter.withFunction((oldValue, newValue) {
              try {
                final text = newValue.text;
                if (text.isNotEmpty) double.parse(text);
                return newValue;
              } catch (e) {}
              return oldValue;
            }),
          ],
        ),
      );

  bool isBetween(num value, num min, num max) {
    if (value <= max && value >= min) {
      return true;
    }
    return false;
  }
}
