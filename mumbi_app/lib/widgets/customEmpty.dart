import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget Empty(String image, String message){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(image != "")
        SvgPicture.asset(image,height: 160,),
        SizedBox(height: 10,),
        Align(alignment: Alignment.center ,child: Text(message ,style: TextStyle(fontSize: 18),)),
      ],
    ),
  );
}

Widget InvisibleBox(){
  return SizedBox.shrink();
}
