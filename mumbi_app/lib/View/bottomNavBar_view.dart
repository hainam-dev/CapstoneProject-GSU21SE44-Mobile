import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/View/changeAccount_view.dart';
import 'package:mumbi_app/View/tracking_view.dart';
import 'dashboard_view.dart';
import 'guideBook_view.dart';

class BotNavBar extends StatefulWidget {
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int selectedIndex = 0;
  Widget _dashBoard = DashBoard();
  Widget _guildBook = GuideBook();
  Widget _tracking = Tracking();
  Widget _changeAccount = ChangeAccount(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getBotNavBar(),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._dashBoard;
    } else if (this.selectedIndex == 1) {
      return this._guildBook;
    } else {
      if(CurrentMember.role == MOM_ROLE){
        if(CurrentMember.pregnancyFlag == true){
          return this._tracking;
        }else{
          return this._changeAccount;
        }
      }else{
        return this._tracking;
      }
    }
  }

  Widget getBotNavBar() {
    return BottomNavigationBar(
      backgroundColor: WHITE_COLOR,
      type: BottomNavigationBarType.fixed,
      currentIndex: this.selectedIndex,
      unselectedItemColor: GREY_COLOR,
      selectedIconTheme: IconThemeData(
        color: PINK_COLOR,
        opacity: 1.0,
      ),
      unselectedIconTheme: IconThemeData(
        color: GREY_COLOR,
        opacity: 1.0,
      ),
      items: [
        item(Icon(Icons.home_outlined), "Trang Chủ"),
        item(Icon(Icons.article_outlined,), "Cẩm Nang"),
        item(Icon(Icons.equalizer_outlined), "Theo Dõi"),
      ],
      onTap: (int index) {
        this.setState(() {
          this.selectedIndex = index;
        });
      },
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

item(
  Icon _icon,
  String _name,
) {
  return BottomNavigationBarItem(
    icon: _icon,
    title: Text(
      _name,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
