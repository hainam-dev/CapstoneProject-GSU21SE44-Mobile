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
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: LIGHT_GREY_COLOR,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 45,
                  width: SizeConfig.blockSizeHorizontal * 35,
                  child: new FlatButton(
                    child: new Text(titleCancel,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600)),
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
              Flexible(
                child: Container(
                    height: 45,
                    width: SizeConfig.blockSizeHorizontal * 65,
                    child: new FlatButton(
                      child: new Text(
                        titleSave,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      textColor: Colors.white,
                      color: PINK_COLOR,
                      onPressed: widget.saveFunction,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),
                    )),
                flex: 2,
              ),
            ],
          ),
        ),
      );
}
