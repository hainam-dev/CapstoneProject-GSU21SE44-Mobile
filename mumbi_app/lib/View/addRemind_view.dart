import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/widgets/customBottomButton.dart';
import 'package:mumbi_app/widgets/customStatusDropdown.dart';
import 'package:mumbi_app/widgets/customText.dart';
import 'package:mumbi_app/widgets/timePicker.dart';

class AddRemindScreen extends StatefulWidget {
  @override
  _AddRemindScreenState createState() => _AddRemindScreenState();
}

class _AddRemindScreenState extends State<AddRemindScreen> {
  List<bool> chooseDate = List.generate(7, (index) => false);
  List<int> _listDate = List.generate(7, (index) => index);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: 'Thêm nhắc nhở',
          size: 20.0,
          color: Colors.white,
        ),
      ),
      body: Container(
        color: WHITE_COLOR,
        margin: EdgeInsets.only(top: 16.0),
        padding: EdgeInsets.all(16.0),
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStatusDropdown(
              'Chọn loại nhắc nhở',
              listRemind,
              "",
              function: (value) {
                setState(
                  () {},
                );
              },
            ),
            SizedBox(
              height: 16.0,
            ),
           TimePicker(),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Chọn thời gian nhắc nhở',
                  size: 16,
                  weight: FontWeight.w400,
                ),
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: PINK_COLOR),
              ],
            ),
            showChooseDate(),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [buildChooseDate()],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        titleCancel: 'Xóa',
        titleSave: 'Lưu nhắc nhở',
        cancelFunction: () => {Navigator.pop(context)},
        saveFunction: () => {print('Clicked add remind')},
      ),
    );
  }

  Widget showChooseDate() => Container(
        margin: EdgeInsets.only(top: 16.0),
        height: 20.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _listDate.length,
            itemBuilder: (context, index) {
              return CustomText(
                text: (chooseDate[index])
                    ? ((_listDate[index] != _listDate.length - 1)
                        ? 'T.${_listDate[index] + 2}, '
                        : 'CN')
                    : '',
                size: 14.0,
                weight: FontWeight.w400,
                color: Color.fromRGBO(66, 66, 66, 1),
              );
            }),
      );

  Widget buildChooseDate() => Container(
        height: 32.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _listDate.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  chooseDate[index] = !chooseDate[index];
                });
              },
              child: Container(
                width: 32.0,
                margin: (_listDate[index] != _listDate.length - 1)
                    ? EdgeInsets.only(right: 19.83)
                    : null,
                decoration: chooseDate[index]
                    ? BoxDecoration(
                        border: Border.all(width: 2, color: PINK_COLOR),
                        borderRadius: BorderRadius.circular(8.0))
                    : null,
                child: Center(
                  child: Text(
                    (_listDate[index] != _listDate.length - 1)
                        ? 'T.${_listDate[index] + 2}'
                        : 'CN',
                    style: TextStyle(
                      color: PINK_COLOR,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

  final List<DropdownMenuItem<String>> listRemind = [
    DropdownMenuItem(
      value: 'Giờ uống nước',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            remindDrink,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Giờ uống nước',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Giờ cho con bú',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            remindMilk,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Giờ cho con bú',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Giờ nghe nhạc',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            remindMusic,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Giờ nghe nhạc',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Giờ đi ngủ',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            remindSleep,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Giờ đi ngủ',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Giờ tập thể dục',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            remindFitness,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Giờ tập thể dục',
            ),
          ),
        ],
      ),
    ),
  ];
}
