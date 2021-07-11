import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customText.dart';

class CustomStatusDropdown extends StatefulWidget {
  final title;
  final listItems;
  final function;
  final status;
  const CustomStatusDropdown(this.title, this.listItems, this.status,
      {this.function});

  @override
  _CustomStatusDropdownState createState() =>
      _CustomStatusDropdownState(this.title, this.listItems);
}

class _CustomStatusDropdownState extends State<CustomStatusDropdown> {
  String selectedValue;
  String title;
  var listItems;
  _CustomStatusDropdownState(this.title, this.listItems);
  @override
  Widget build(BuildContext context) {
    return _buildStatus(title, listItems);
  }

  Widget _buildStatus(String title, List<DropdownMenuItem> listItems) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7.5,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: new DropdownButtonFormField<String>(
          value: widget.status,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: PINK_COLOR,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato'),
            labelText: title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          items: widget.listItems,
          onChanged: widget.function,
          validator: (value) {
            if (value == null) {
              if (title == "Trạng thái (*)") {
                return "Chọn trạng thái cho bé";
              } else if (title == 'Giới tính (*)') {
                return "Chọn giới tính cho bé";
              }
            }
            return null;
          },
          // value: _value,
          isExpanded: true,
        ),
      );
}
