import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CustomInputText extends StatefulWidget {
  final title;
  final value;
  const CustomInputText(this.title, this.value);
  @override
  _CustomInputTextState createState() => _CustomInputTextState(title,value);
}

class _CustomInputTextState extends State<CustomInputText> {
  String title;
  String value;
  _CustomInputTextState(this.title,this.value);

  @override
  Widget build(BuildContext context) {
    return _buildUsername(title);
  }

  Widget _buildUsername(String name) => Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          initialValue: value,
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w100),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: name,
            hintStyle: TextStyle(color: PINK_COLOR),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
            ),
          ),
          validator: (value) {
            if (value.length < 4) {
              return 'Enter at least 4 characters';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => value),
          keyboardType: TextInputType.name,
        ),
      );
}
