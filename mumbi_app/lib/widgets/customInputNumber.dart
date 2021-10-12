import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

class CustomInputNumber extends StatefulWidget {
  final title;
  final number;
  final function;
  final checkValidation;
  const CustomInputNumber(this.title, this.number,
      {this.function, this.checkValidation});
  @override
  _CustomInputNumberState createState() =>
      _CustomInputNumberState(title, number);
}

class _CustomInputNumberState extends State<CustomInputNumber> {
  String title;
  String number = '';
  _CustomInputNumberState(this.title, this.number);

  @override
  Widget build(BuildContext context) {
    return _buildPhoneNumber(title);
  }

  Widget _buildPhoneNumber(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 6),
    child: TextFormField(
      initialValue: number,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: PINK_COLOR),
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
        ),
      ),
      validator: (value) {
        final phonePattern = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
        final regPho = RegExp(phonePattern);
        if (value.isEmpty) {
          return null;
        } else if (title == 'Số điện thoại' && !regPho.hasMatch(value)) {
          return 'Định dạng Số điện thoại không đúng.';
        } else if (title == 'Xoáy đầu' &&
            !isBetween(int.parse(value), 0, 4)) {
          return 'Số xoáy đầu từ 0 đến 4.';
        } else if (title == 'Số vân tay' &&
            !isBetween(int.parse(value), 0, 10)) {
          return 'Số vân tay từ 0 đến 10.';
        } else {
          return null;
        }
      },
      onChanged: widget.function,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ),
  );

  bool isBetween(int value, int min, int max) {
    if (value <= max && value >= min) {
      return true;
    }
    return false;
  }
}
