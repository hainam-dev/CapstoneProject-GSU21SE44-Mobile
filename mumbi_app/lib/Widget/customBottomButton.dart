import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CustomBottomButton extends StatefulWidget {
  final saveFunction;
  final cancelFunction;
  final titleCancel;
  final titleSave;

  const CustomBottomButton(
      {this.saveFunction,
      this.cancelFunction,
      this.titleCancel,
      this.titleSave});
  @override
  _CustomBottomButtonState createState() =>
      _CustomBottomButtonState(this.titleCancel, this.titleSave);
}

class _CustomBottomButtonState extends State<CustomBottomButton> {
  final titleCancel;
  final titleSave;
  _CustomBottomButtonState(this.titleCancel, this.titleSave);

  @override
  Widget build(BuildContext context) {
    return _getActionButtons(this.titleCancel, this.titleSave);
  }

  Widget _getActionButtons(String titleCancel, String titleSave) => Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 36),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: new FlatButton(
                  child: new Text(titleCancel),
                  textColor: PINK_COLOR,
                  onPressed: widget.cancelFunction,
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
                    child: new Text(titleSave),
                    textColor: Colors.white,
                    color: PINK_COLOR,
                    onPressed: widget.saveFunction,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                  )),
              flex: 2,
            ),
          ],
        ),
      );
}
