import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CustomBottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getActionButtons();
  }

  Widget _getActionButtons() => Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: new FlatButton(
                  child: new Text("Hủy"),
                  textColor: PINK_COLOR,
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side:
                          BorderSide(color: Color.fromRGBO(255, 240, 244, 1))),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Container(
                  height: SizeConfig.blockSizeVertical * 7,
                  width: SizeConfig.blockSizeHorizontal * 65,
                  child: new RaisedButton(
                    child: new Text("Lưu thông tin"),
                    textColor: Colors.white,
                    color: PINK_COLOR,
                    onPressed: () {},
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                  )),
              flex: 2,
            ),
          ],
        ),
      );
}
