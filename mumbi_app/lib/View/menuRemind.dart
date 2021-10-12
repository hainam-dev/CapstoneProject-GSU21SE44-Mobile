import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/core/auth/login/views/login_view.dart';
import 'package:mumbi_app/widgets/customText.dart';

import 'listRemind_view.dart';

class MenuRemind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: 'Nhắc nhở',
          size: 20.0,
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        children: [
          createListTile(
              context, remindDrink, 'Giờ uống nước', ListRemindScreen()),
          createListTile(context, remindMilk, 'Giờ cho con bú', LoginScreen()),
          createListTile(context, remindMusic, 'Nghe nhạc', LoginScreen()),
          createListTile(context, remindSleep, 'Giờ đi ngủ', LoginScreen()),
          createListTile(
              context, remindFitness, 'Giờ tập thể dục', LoginScreen()),
        ],
      ),
    );
  }

  Widget createListTile(
      BuildContext context, String _imageName, String _text, Widget _screen) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Image(
          image: AssetImage(_imageName),
          height: SizeConfig.safeBlockVertical * 6,
          width: SizeConfig.safeBlockHorizontal * 8,
        ),
        title: Text(
          _text,
          style: TextStyle(
              fontFamily: 'Lato',
              color: Color.fromRGBO(33, 33, 33, 1),
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _screen));
        },
      ),
    );
  }
}
