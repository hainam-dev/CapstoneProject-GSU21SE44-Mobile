import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customText.dart';

class CustomStatusDropdown extends StatefulWidget {
  final title;
  final title1;
  final title2;
  final image1;
  final image2;
  final function;
  const CustomStatusDropdown(
      this.title, this.title1, this.title2, this.image1, this.image2,
      {this.function});

  @override
  _CustomStatusDropdownState createState() => _CustomStatusDropdownState(
      this.title, this.title1, this.title2, this.image1, this.image2);
}

class _CustomStatusDropdownState extends State<CustomStatusDropdown> {
  String selectedValue;
  String title;
  String title1;
  String title2;
  String image1;
  String image2;
  _CustomStatusDropdownState(
      this.title, this.title1, this.title2, this.image1, this.image2);
  @override
  Widget build(BuildContext context) {
    return _buildStatus(title, title1, title2, image1, image2);
  }

  Widget _buildStatus(String title, String title1, String title2, String image1,
          String image2) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7.5,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: new DropdownButtonFormField<String>(
          value: selectedValue,
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

          items: [
            DropdownMenuItem(
              value: title1,
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    image1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new CustomText(
                      text: title1,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: title2,
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    image1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new CustomText(
                      text: title2,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: widget.function,
          // value: _value,
          isExpanded: true,
        ),
      );
}
