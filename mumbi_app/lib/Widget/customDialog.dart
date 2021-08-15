import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class CustomDialog extends StatelessWidget {
  final String title, description;
  final String image;

  CustomDialog({
    this.title,
    this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.only(
            top: 24.0,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(
            top: Consts.avatarRadius,
            bottom: Consts.avatarRadius * 1.5,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Image.asset(image,width: 70,height: 70,),
              SizedBox(
                height: 16.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

void showResult(BuildContext context, bool result, String SuccessResult) {
  if (result) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Thành công!",
        description: SuccessResult,
        image: checked,
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Thất bại",
        description: "Có lỗi xảy ra vui lòng thử lại sau",
        image: unchecked,
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
