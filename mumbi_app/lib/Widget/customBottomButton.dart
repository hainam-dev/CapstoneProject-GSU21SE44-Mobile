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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: 50.0,
                  child: new FlatButton(
                    child: new Text(titleCancel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    textColor: PINK_COLOR,
                    color: WHITE_COLOR,
                    onPressed: widget.cancelFunction,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: PINK_COLOR)),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 50.0,
                  child: new FlatButton(
                    child: new Text(
                      titleSave,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    textColor: Colors.white,
                    color: PINK_COLOR,
                    onPressed: widget.saveFunction,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
