import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/View/changeAccount_view.dart';
import 'package:mumbi_app/View/drawer_view.dart';
import 'package:mumbi_app/View/guidebook_view.dart';
import 'package:mumbi_app/View/savedPost_view.dart';
import 'package:mumbi_app/View/tracking_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/news_viewmodel.dart';
import 'package:mumbi_app/Widget/customEmpty.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dashboard_view.dart';

class BotNavBar extends StatefulWidget {
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int selectedIndex = 0;
  Widget _dashBoard = DashBoard();
  Widget _guideBook = GuidebookCategory();
  Widget _tracking = Tracking();
  Widget _changeAccount = ChangeAccount();

  NewsViewModel _newsViewModel;
  MomViewModel _momViewModel;
  ChildViewModel _childViewModel;

  @override
  void initState() {
    super.initState();
    _newsViewModel = NewsViewModel.getInstance();
    _newsViewModel.getNews();

    _momViewModel = MomViewModel.getInstance();
    _momViewModel.getMomByID();

    _childViewModel = ChildViewModel.getInstance();
    _childViewModel.getChildByMom();

    if (CurrentMember.role == CHILD_ROLE)
      _childViewModel.getChildByID(CurrentMember.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: AppBar(
        title: Text(getTitle()),
        actions: [
          getAction(),
        ],
      ),
      drawer: getDrawer(context),
      bottomNavigationBar: getBotNavBar(),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._dashBoard;
    } else if (this.selectedIndex == 1) {
      return this._guideBook;
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
    return Container(
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        boxShadow: [
          BoxShadow(
            color: GREY_COLOR,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: WHITE_COLOR,
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          item(dashboard, "Trang chủ",selectedIndex == 0 ? PINK_COLOR : GREY_COLOR),
          item(guidebook, "Cẩm nang",selectedIndex == 1 ? PINK_COLOR : GREY_COLOR),
          item(tracking, "Theo dõi",selectedIndex == 2 ? PINK_COLOR : GREY_COLOR),
        ],
        onTap: (int index) {
          this.setState(() {
            this.selectedIndex = index;
          });
        },
      ),
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  String getTitle(){
    if(selectedIndex == 0){
      return "Trang chủ";
    }else if(selectedIndex == 1){
      return "Cẩm nang";
    }else {
      return "Theo dõi";
    }
  }

  Widget getAction(){
    if(selectedIndex == 0){
      return ChangeAccountButton();
    }else if(selectedIndex == 1){
      return ButtonGotoSavePost();
    }else {
      return InvisibleBox();
    }
  }

  Widget ButtonGotoSavePost() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
            icon: SvgPicture.asset(
                saved
            ),
            onPressed: () =>
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedPost(0)),
              )
            }),
      ),
    );
  }

  Widget ChangeAccountButton() {
    return FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangeAccount()));
        },
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (CurrentMember.role == CHILD_ROLE)
              Positioned(
                  left: 5,
                  child: ChildAvatar()
              ),
            Positioned(
                right: CurrentMember.role == CHILD_ROLE ? 5 : null,
                child: MomAvatar()
            ),
            if (CurrentMember.role == CHILD_ROLE)
              Positioned(
                  child: SvgPicture.asset(swap,height: 20,)
              ),
          ],
        ));
  }

  Widget MomAvatar() {
    return ScopedModel(
      model: _momViewModel,
      child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MomViewModel model) {
            return model.momModel == null
                ? CircleAvatar(
              backgroundColor: WHITE_COLOR,
              radius: 17,
            )
                : CircleAvatar(
              backgroundColor: LIGHT_DARK_PINK_COLOR,
              radius: 20,
              child: CircleAvatar(
                radius: 17,
                backgroundImage:
                CachedNetworkImageProvider(model.momModel.imageURL),
              ),
            );
          }),
    );
  }

  Widget ChildAvatar() {
    return ScopedModel(
        model: _childViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ChildViewModel model) {
            return model.childModel == null
                ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
            )
                : Stack(
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundColor: WHITE_COLOR,
                ),
                CircleAvatar(
                  radius: 17,
                  backgroundImage:
                  CachedNetworkImageProvider(model.childModel.imageURL),
                ),
                CircleAvatar(
                  radius: 17,
                  backgroundColor: BLACK_COLOR.withOpacity(0.4),
                ),
              ],
            );
          },
        ));
  }
}

item(String _icon, String _name, Color color) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(_icon,color: color,),
    label: _name,
  );
}


