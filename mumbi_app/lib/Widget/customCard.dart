import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';

Widget HighLightsCardItem(String imageURL, String title, String createTime, num estimatedTime,
    {Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Card(
      margin: EdgeInsets.zero,
      color: LIGHT_GREY_COLOR,
      clipBehavior: Clip.antiAlias,
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: Ink.image(
          image: CachedNetworkImageProvider(
            imageURL,
          ),
          fit: BoxFit.cover,
        ),
        bottomNavigationBar: Container(
          color: BLACK_COLOR.withOpacity(0.4),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: WHITE_COLOR),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                        child: SvgPicture.asset(readIcon,
                            height: 16, width: 16, color: WHITE_COLOR)),
                    SizedBox(width: 5),
                    Text(
                      estimatedTime.toString() + " phút đọc",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: WHITE_COLOR),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget NormalCardItem(String imageURL, String title, String createTime, num estimatedTime,
    {Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: LIGHT_GREY_COLOR,
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                ),
                height: 90,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  child: CachedNetworkImage(
                    imageUrl: imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                            DateTimeConvert.convertDatetimeDMY(
                                createTime),
                            style: TextStyle(
                                fontSize: 14.0,
                                color: LIGHT_DARK_GREY_COLOR)),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.fiber_manual_record,
                          color: GREY_COLOR,
                          size: 6,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          estimatedTime.toString() +
                              " phút đọc",
                          style: TextStyle(
                              fontSize: 14, color: LIGHT_DARK_GREY_COLOR),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}