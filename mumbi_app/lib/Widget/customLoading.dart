import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingProgress(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );
}