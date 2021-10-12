import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/modules/growing_teeth/models/teeth_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:progress_dialog/progress_dialog.dart';

Widget createTextFeild(String title, String hintText, String value, ontap) {
  return Container(
    padding: EdgeInsets.only(top: 12),
    child: TextFormField(
      initialValue: value,
      maxLength: 200,
      onChanged: ontap,
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

Widget createListTileDetail(String name, String detail, String image) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(65),
          child: image.isNotEmpty
              ? Image.network(
                  image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                )
              : null),
      subtitle: Text(
        detail,
        style: SEMIBOLD_14_6,
      ),
      title: Text(
        name,
        style: SEMIBOLDPINK_16_6,
      ),
      onTap: () => {},
      // trailing: Icon(Icons.keyboard_arrow_down_outlined),
    ),
  );
}

Widget createListTileNext(
    BuildContext context, String day, String title, Widget screen) {
  return Container(
    color: WHITE_COLOR,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: new BoxDecoration(
          color: LIGHT_BLUE_COLOR,
        ),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.grey, child: SvgPicture.asset(ic_needle)),
          subtitle: Text(
            day,
            style: BOLD_15,
          ),
          title: Text(
            title,
            style: SEMIBOLD_16,
          ),
          trailing: Icon(Icons.navigate_next),
        ),
      ),
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

Widget createFamilyCard(BuildContext context, String _imageURL, String _name,
    Color _labelColor, String _labelText, Color _labelTextColor,
    {Function onClick}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 230,
    ),
    child: Container(
      height: 200,
      width: SizeConfig.blockSizeHorizontal * 50,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: RaisedButton(
            color: WHITE_COLOR,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            splashColor: TRANSPARENT_COLOR,
            highlightColor: GREY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                          radius: 37,
                          backgroundColor: PINK_COLOR,
                          backgroundImage:
                              CachedNetworkImageProvider(_imageURL)),
                      Positioned(
                        top: -1,
                        right: -8,
                        child: Container(
                          child: SvgPicture.asset(
                            editpencil,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                      if (_labelText == "Mẹ bầu")
                        Positioned(
                          bottom: 1,
                          left: 1,
                          child: Container(
                            child: SvgPicture.asset(
                              mecobau,
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
            onPressed: () {
              onClick();
            }),
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
            width: SizeConfig.safeBlockHorizontal * 30,
            child: Text(
              _name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: SizedBox(
            width: SizeConfig.safeBlockHorizontal * 40,
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
          width: SizeConfig.safeBlockHorizontal * 15,
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
    height: 40,
    child: RaisedButton(
      splashColor: TRANSPARENT_COLOR,
      highlightColor: LIGHT_PINK_COLOR,
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        )
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: BOLDPINK_16,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget createAddFamilyCard(BuildContext context, String _title,
    {Function onClick}) {
  return Container(
    height: 200,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: RaisedButton(
          color: WHITE_COLOR,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          splashColor: TRANSPARENT_COLOR,
          highlightColor: GREY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(empty),
              Text(
                _title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
          onPressed: () {
            onClick();
          }),
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
            child: SvgPicture.asset(btn_plus),
          ),
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
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        // color: Colors.blue,
        child: IconButton(
          icon: SvgPicture.asset(
              choose ? teethModel.iconChoose : teethModel.icon),
          onPressed: ontap,
        ),
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
      alignment: Alignment.topLeft,
      child: Text(text, style: textStyle),
    ),
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
        createTextAlign("Thông tin", BOLD_18),
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
          createTextAlign("Bé của bạn ( Bé " + name + "):", BOLD_18),
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
      textAlign: TextAlign.center,
    ),
  );
}

Widget createTextBlueHyperlink(
    BuildContext context, String title, Widget screen) {
  return GestureDetector(
      child: Text(title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              color: Colors.lightBlueAccent)),
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

Widget createFieldPassword(String title, String hintText, bool isHidePassword,
    TextEditingController controller, Function passwordView) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: TextFormField(
      controller: controller,
      obscureText: isHidePassword,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
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
void showCustomProgressDialog(
    BuildContext context,
    String message,
    Future<dynamic> future,
    Pair<bool, String> Function(dynamic) onHasData) async {
  ProgressDialog dialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);
  dialog.style(
    message: message,
  );
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
