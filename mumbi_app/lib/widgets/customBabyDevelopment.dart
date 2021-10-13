import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/modules/development_milestone/views/standard_index_view.dart';

import 'customComponents.dart';

Widget createBabyCondition(
    BuildContext context, String stringBMI, String state) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            'Thể trạng của bé',
            style: BOLD_20,
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 45,
              // margin: EdgeInsets.only(right: 0),
              alignment: Alignment.topRight,
              child: createTextBlueHyperlink(
                  context, "Chỉ số tiêu chuẩn", StandardIndex())),
        ],
      ),
      Container(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            Text(
              "BMI của bé: ",
              style: SEMIBOLD_16,
            ),
            Text(
              stringBMI != 0.toString() ? stringBMI : "",
              style: REGGREEN_16,
            ),
            Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  state,
                  style: REGGREEN_16,
                ))
          ],
        ),
      )
    ],
  );
}
