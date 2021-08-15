import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, String ContinueText, String ConfirmMessage, {Function ContinueFunction}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Hủy"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text(ContinueText),
    onPressed: ContinueFunction,
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    title: Text("Lưu ý",style: TextStyle(fontWeight: FontWeight.w600),),
    content: Text(ConfirmMessage),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}