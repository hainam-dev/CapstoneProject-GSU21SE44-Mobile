import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/activity_model.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/babyDevelopment_view.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/teethTrack_view.dart';
import 'package:mumbi_app/ViewModel/activity_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Widget/custom_playlist.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'drawer_view.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  ChildViewModel _childViewModel;

  @override
  void initState() {
    super.initState();
    _childViewModel = ChildViewModel.getInstance();
    if (CurrentMember.pregnancyFlag == true) {
      _childViewModel.getChildByID(CurrentMember.pregnancyID);
    } else {
      _childViewModel.getChildByID(CurrentMember.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _childViewModel,
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
        return Scaffold(
          body: model.childModel == null
              ? loadingProgress()
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(13, 30, 13, 10),
                  child: Column(
                    children: <Widget>[
                      CircleThing(model.childModel),
                      SizedBox(
                        height: 23,
                      ),
                      ListTileFunction(developmentMilestone,"Mốc phát triển",BabyDevelopment()),
                      if(CurrentMember.role == CHILD_ROLE)
                      ListTileFunction(teethGrow,"Mọc răng", TeethTrack()),
                      if(CurrentMember.role == CHILD_ROLE)
                      ListTileFunction(injection,"Tiêm chủng", InjectionSchedule()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },),
    );
  }



  Widget CircleThing(ChildModel childModel) {
    return Container(
      height: 230,
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        color: Color(0xFFFC95AE),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 45),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              color: Color(0xFFFB668A),
            ),
            child: SvgPicture.asset(CurrentMember.pregnancyFlag == true
                ? img_beco
                : getGenderImage(childModel.gender)),
          ),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                CurrentMember.pregnancyFlag == true
                    ? "Thai kì đã được"
                    : "Bé đã được",
                style: SEMIBOLDWHITE_13,
              )),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                CurrentMember.pregnancyFlag == true
                    ? DateTimeConvert.pregnancyWeekAndDay(
                    childModel.estimatedBornDate)
                    : DateTimeConvert.calculateChildAge(childModel.birthday),
                style: TextStyle(fontSize: 18,color: WHITE_COLOR,fontWeight: FontWeight.w600),
              )),
          CurrentMember.pregnancyFlag == true
              ? createFlatButton(context, 'Bé đã ra đời',
              ChildrenInfo(childModel, UPDATE_STATE, CHILD_ENTRY))
              : Container(),
        ],
      ),
    );
  }

  String getGenderImage(num gender) {
    switch (gender) {
      case 1:
        return img_betrai;
        break;
      case 2:
        return img_begai;
        break;
      default:
        return img_beco;
        break;
    }
  }

  Widget ListTileFunction(String image, String name, Widget _screen){
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: SvgPicture.asset(image,height: 32,),
        title: Text(name,style: TextStyle(fontSize: 17),),
        trailing: Icon(Icons.arrow_forward_ios, size: 15,color: BLACK_COLOR,),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _screen));
        },
      ),
    );
  }

  Widget Empty(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
          child: Text(
            title,
            style: TextStyle(color: GREY_COLOR),
          )),
    );
  }
}
