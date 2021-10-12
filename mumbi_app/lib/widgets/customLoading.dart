import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

Widget loadingProgress(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );
}

Widget loadingCheckSaved(){
  return IconButton(
      icon: Icon(Icons.bookmark_border_outlined,size: 28,color:  WHITE_COLOR.withOpacity(0.4),),
      onPressed: null);
}