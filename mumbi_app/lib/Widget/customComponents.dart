import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mumbi_app/Model/playlist_model.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/View/teethDetail_view.dart';
import 'package:progress_dialog/progress_dialog.dart';

Widget createTextFeild(String title, String hintText, String value, ontap) {
  return Container(
    padding: EdgeInsets.only(top: 12),
    child: TextFormField(
      initialValue: value,
      maxLength: 200,
      onFieldSubmitted: ontap,
      decoration: InputDecoration(
          labelStyle: SEMIBOLDPINK_16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          labelText: title,
          hintText: hintText),
    ),
  );
}

Widget createButtonConfirm(String title, ontap) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        width: 170,
        height: 50,
        child: ElevatedButton(
          onPressed: ontap,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
          child: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ),
    ),
  );
}

Widget createButtonCancel(BuildContext context, String title, Widget _screen) {
  return SizedBox(
    width: 120,
    height: 50,
    child: RaisedButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _screen),
        )
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

Widget createListTile(String imageUrl, String name) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: Image.network(
          imageUrl,
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(name),
      onTap: () => {},
    ),
  );
}

Widget createListTileDetail(String name, String detail) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.assignment_ind_sharp)),
      subtitle: Text(name),
      title: Text(detail),
      onTap: () => {},
      trailing: Icon(Icons.keyboard_arrow_down_outlined),
    ),
  );
}

Widget createListTileNext(String name, String detail) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: new BoxDecoration(
      color: LIGHT_BLUE_COLOR,
    ),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey, child: SvgPicture.asset(ic_needle)),
      subtitle: Text(name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      title: Text(
        detail,
      ),
      onTap: () => {},
      trailing: Icon(Icons.navigate_next),
    ),
  );
}

Widget createListOption(int value, onChange) {
  int _value = 1;
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Row(children: <Widget>[
      CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.assignment_ind_sharp)),
      Text('bé bông'),
      DropdownButton(
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text("First Item"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Second Item"),
              value: 2,
            ),
            DropdownMenuItem(child: Text("Third Item"), value: 3),
            DropdownMenuItem(child: Text("Fourth Item"), value: 4)
          ],
          onChanged: onChange),
    ]),
  );
}

Widget createDataWithIcon(String name) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.assignment_ind_sharp)),
        Text(name),
      ],
    ),
  );
}

Widget createData(String name) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Text(name),
  );
}

Widget createFamilyCard(
    BuildContext context,
    String _imageURL,
    String _name,
    Color _labelColor,
    String _labelText,
    Color _labelTextColor,
    Widget _screen) {
  return Container(
    height: SizeConfig.blockSizeVertical * 22,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: RaisedButton(
        color: WHITE_COLOR,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          height: SizeConfig.safeBlockVertical * 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: 39,
                        backgroundColor: PINK_COLOR,
                        backgroundImage: CachedNetworkImageProvider(_imageURL)),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        child: SvgPicture.asset(
                          editpencil,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Card(
                elevation: 0,
                color: _labelColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    _labelText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: _labelTextColor, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => _screen)),
      ),
    ),
  );
}

Widget createFlatButton(BuildContext context, String _title, Widget _screen) {
  return FlatButton(
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _screen),
      )
    },
    color: Colors.white,
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.pinkAccent),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Text(
      _title,
      style: TextStyle(
        color: Colors.pinkAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget createLinear(String _name, double _value, Color _color) {
  return Container(
    padding: EdgeInsets.only(
      top: 16,
    ),
    child: Row(
      children: <Widget>[
        Container(
            width: 100,
            child: Text(
              _name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              minHeight: 16,
              value: _value,
              // semanticsValue:"Percent " + (_value * 100).toString() + "%",
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(_color),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            (_value * 100).round().toString() + "%",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
  );
}

Widget createButtonWhite(
    BuildContext context, String title, double _width, Widget screen) {
  return SizedBox(
    width: _width,
    height: 50,
    child: RaisedButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        )
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Text(
        title,
        style: BOLDPINK_16,
      ),
    ),
  );
}

Widget createAddFamilyCard(
    BuildContext context, String _title, Widget _screen) {
  return Container(
    height: SizeConfig.blockSizeVertical * 22,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: RaisedButton(
        color: WHITE_COLOR,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          height: SizeConfig.safeBlockVertical * 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 39,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(empty),
              ),
              Text(
                _title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => _screen)),
      ),
    ),
  );
}

Widget getButtonUpload(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      decoration: new BoxDecoration(
        color: GREY_100,
      ),
      child: SizedBox(
        width: 80,
        height: 80,
        child: DottedBorder(
          strokeCap: StrokeCap.butt,
          color: GREY_COLOR_LIGHT,
          // gap: 3,
          strokeWidth: 1,
          child: Center(
              child: FlatButton(
            child: SvgPicture.asset(btn_plus),
          )),
        ),
      ),
    ),
  );
}

Widget createTeeth(ToothInfoModel teethModel, bool choose, ontap) {
  return Positioned(
    height: teethModel.height,
    width: teethModel.width,
    top: teethModel.top,
    left: teethModel.left,
    child: Container(
      child: IconButton(
        icon:
            SvgPicture.asset(choose ? teethModel.iconChoose : teethModel.icon),
        onPressed: ontap,
      ),
    ),
  );
}

Widget createTextAlign(String text, TextStyle textStyle) {
  return Container(
    margin: EdgeInsets.only(
      top: 8,
    ),
    child: Align(
        alignment: Alignment.topLeft, child: Text(text, style: textStyle)),
  );
}

Widget createTextAlignInformation(
    String position, String name, String growTime) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
    decoration: new BoxDecoration(color: Colors.white),
    child: Column(
      children: <Widget>[
        createTextAlign("Thông tin", SEMIBOLD_18),
        createTextAlign("Răng số " + position, SEMIBOLD_16),
        createTextAlign("Tên gọi: " + name, SEMIBOLD_16),
        createTextAlign("Thời gian mọc: " + growTime, SEMIBOLD_16),
      ],
    ),
  );
}

Widget createTextAlignUpdate(BuildContext context, String name, String status,
    String growTime, Widget screen) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    decoration: new BoxDecoration(color: Colors.white),
    child: Container(
      child: Column(
        children: <Widget>[
          createTextAlign("Bé của bạn (" + name + "):", SEMIBOLD_18),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      createTextAlign("Trạng thái: " + status, SEMIBOLD_16),
                      createTextAlign("Ngày mọc: " + growTime, SEMIBOLD_16),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  child: Center(
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => screen),
                          )
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        child: Text(
                          'Cập nhật',
                          style: BOLD_16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget createBottomNavigationBar(
    BuildContext context, String stringCancel, String stringUpdate, ontap) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
    child: Row(
      children: <Widget>[
        createButtonCancel(context, stringCancel, context.widget),
        createButtonConfirm(stringUpdate, ontap)
      ],
    ),
  );
}

Widget createTextFormFeild(String title, String hintText, String value, ontap) {
  return Container(
    padding: EdgeInsets.only(top: 12),
    child: TextFormField(
      onChanged: (text) {
        text = value;
      },
      validator: (string) {
        if (value == "" && string.length == 0) {
          return 'Vui lòng nhập họ và tên';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          labelStyle: SEMIBOLDPINK_16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          labelText: title,
          hintText: hintText),
    ),
  );
}

Widget createTextFeildDisable(String title, String value) {
  return Container(
    padding: EdgeInsets.only(top: 12),
    child: TextFormField(
      initialValue: value,
      enabled: false,
      decoration: InputDecoration(
        labelStyle: SEMIBOLDPINK_16,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        labelText: title,
        // prefixText: value
      ),
    ),
  );
}

Widget createTextTitle(String title) {
  return Container(
    child: Text(
      title,
      style: SEMIBOLD_16,
    ),
  );
}

Widget createTextBlueHyperlink(
    BuildContext context, String title, Widget screen) {
  return GestureDetector(
      child: Text(title,
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.blue)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      });
}

Widget createTextBlue(BuildContext context, String title, ontap) {
  return GestureDetector(
    child: Text(title,
        style: TextStyle(
            decoration: TextDecoration.underline, color: Colors.blue)),
    onTap: ontap,
  );
}

Widget createFormPhone(
    BuildContext context, String hintText, String phone, onChange) {
  return Container(
    padding: EdgeInsets.all(16),
    child: TextFormField(
      onChanged: onChange,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelStyle: SEMIBOLDPINK_16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          hintText: hintText),
    ),
  );
}

Widget backButton(BuildContext context, Widget screen) {
  return IconButton(
    icon: Icon(Icons.keyboard_backspace),
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      )
    },
  );
}

Widget createFieldPassword(String title, String hintText, bool isHidePassword,
    TextEditingController controller, passwordView) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: TextFormField(
      controller: controller,
      obscureText: isHidePassword,
      decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          hintText: hintText,
          suffixIcon: InkWell(
              onTap: passwordView,
              child: isHidePassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off))),
    ),
  );
}

class Pair<T, E> {
  T first;
  E second;
  Pair(T first, E second) {
    this.first = first;
    this.second = second;
  }
}

///[Pair] with [Pair.first] is true if success else false, [Pair.second] is error message if [Pair.first] is false
void showCustomProgressDialog(BuildContext context, Future<dynamic> future,
    Pair<bool, String> Function(dynamic) onHasData) async {
  ProgressDialog dialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);
  dialog.style(message: "Vui lòng đợi");
  if (future != null) {
    dialog.show();
  }
  Pair<bool, String> p;
  var error;
  try {
    var data = await future;
    dialog.hide();
    p = onHasData(data);
  } catch (e) {
    dialog.hide();
    print("error: $e");
    error = "Có lỗi xảy ra, vui lòng thử lại";
  }
  Future.delayed(Duration(milliseconds: 300)).then((_) {
    if (dialog.isShowing()) {
      dialog.hide();
    }
  });
  if (p == null || !p.first) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Wrap(
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [Text(error == null ? p.second : error)],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }
}

///
/// Convert a color hex-string to a Color object.
///
Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
