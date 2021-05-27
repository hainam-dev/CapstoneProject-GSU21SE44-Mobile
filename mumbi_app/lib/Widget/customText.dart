  
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final String family;

  const CustomText({Key key, this.text, this.size, this.color, this.weight,this.family}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(fontSize: size ?? 16, color: color ?? Color.fromRGBO(33, 33, 33, 1), fontWeight: weight ?? FontWeight.w500, fontFamily:'Lato' ),
    );
  }
}