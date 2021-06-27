import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CustomInputNumber extends StatefulWidget {
  final title;
  final phoneNumber;
  final function;
  const CustomInputNumber(this.title, this.phoneNumber, {this.function});
  @override
  _CustomInputNumberState createState() => _CustomInputNumberState(title, phoneNumber);
}

class _CustomInputNumberState extends State<CustomInputNumber> {
  String title;
  String phoneNumber = '';
  _CustomInputNumberState(this.title, this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return _buildPhoneNumber(title);
  }

  Widget _buildPhoneNumber(String title) => Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          initialValue: phoneNumber,
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
            final pattern = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
            final regExp = RegExp(pattern);
            if (value.isEmpty) {
              return null;
            } else if (!regExp.hasMatch(value)) {
              return 'Định dạng Số điện thoại không đúng.';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => phoneNumber = value),
          onChanged: widget.function,
          keyboardType: TextInputType.phone,
        ),
      );
}
