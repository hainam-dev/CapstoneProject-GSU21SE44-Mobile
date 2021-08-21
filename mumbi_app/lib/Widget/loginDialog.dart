import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showLoginDialog(BuildContext context,
    {TextEditingController usernameController,
    TextEditingController loginController,
    Function onLoginPressed}) {
  Alert(
      context: context,
      title: "LOGIN",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: onLoginPressed,
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
