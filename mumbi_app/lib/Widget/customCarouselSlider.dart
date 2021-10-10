import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget customCarouselSlider(BuildContext context, int itemCount,
    {Function itemBuilder}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: CarouselSlider.builder(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    ),
  );
}