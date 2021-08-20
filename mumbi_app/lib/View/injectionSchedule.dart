import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/injectionSchedule_model.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/vaccinePrice_compare.dart';
import 'package:mumbi_app/View/injectiondetail_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'injectionVaccinationLogin_view.dart';

class InjectionSchedule extends StatefulWidget {
  @override
  _InjectionScheduleState createState() => _InjectionScheduleState();
}

class _InjectionScheduleState extends State<InjectionSchedule> {
  ChildViewModel childViewModel;
  InjectionScheduleViewModel injectionScheduleViewModel;
  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();
    childViewModel.getChildByID(CurrentMember.pregnancyFlag == true
        ? CurrentMember.pregnancyID
        : CurrentMember.id);

    injectionScheduleViewModel = InjectionScheduleViewModel.getInstance();
    injectionScheduleViewModel.getInjectionSchedule(
        CurrentMember.pregnancyFlag == true
            ? CurrentMember.pregnancyID
            : CurrentMember.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: childViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ChildViewModel model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Lịch sử tiêm chủng'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ChildInfo(model.childModel),
                Align(
                    alignment: Alignment.topRight,
                    child: createTextBlueHyperlink(
                        context,
                        "Cập nhật lịch sử tiêm chủng",
                        InectionVaccinationLogin())),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text("logout"),
                    onPressed: () {
                      VaccinationRespository.logout();
                    },
                  ),
                ),
                Header(),
                InjectTable(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ChildInfo(ChildModel childModel) {
    return ListTile(
        leading: childModel == null
            ? CircleAvatar(radius: 22, backgroundColor: LIGHT_GREY_COLOR)
            : CircleAvatar(
                radius: 22,
                backgroundColor: LIGHT_GREY_COLOR,
                backgroundImage:
                    CachedNetworkImageProvider(childModel.imageURL),
              ),
        title: Text(
          childModel == null ? "..." : childModel.fullName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ));
  }

  Widget InjectTable() {
    return ScopedModel(
      model: injectionScheduleViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            InjectionScheduleViewModel model) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.injectionScheduleListModel == null
                  ? 1
                  : model.injectionScheduleListModel.length,
              itemBuilder: (context, index) {
                if (model.injectionScheduleListModel == null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Center(
                        child: Text(
                            "- Chưa có lịch sử tiêm chủng được ghi nhận -")),
                  );
                } else {
                  InjectionScheduleModel injectModel =
                      model.injectionScheduleListModel[index];
                  return Body(injectModel);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget Header() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          HeaderItem(20, "Ngày tiêm"),
          HeaderItem(55, "Kháng nguyên"),
          HeaderItem(15, "Mũi thứ"),
          HeaderItem(5, ""),
        ],
      ),
    );
  }

  Widget HeaderItem(num size, String name) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * size,
      child: Center(
        child: Text(name,
            style: TextStyle(
                color: WHITE_COLOR, fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget Body(InjectionScheduleModel model) {
    return Column(
      children: [
        ListTile(
            title: Row(children: <Widget>[
          BodyItem(20, CutDate(model.injectionDate), model),
          BodyItem(55, model.antigen, model),
          BodyItem(10, model.orderOfInjection.toString(), model),
          BodyItem(5, "", model),
        ])),
        Divider(height: 1),
      ],
    );
  }

  Widget BodyItem(num size, String name, InjectionScheduleModel model) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * size,
      child: name != ""
          ? Align(
              alignment: Alignment.center,
              child: Text(name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            )
          : IconButton(
              icon: Icon(Icons.visibility),
              color: BLACK_COLOR,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InjectionDetail(model)));
              },
            ),
    );
  }

  String CutDate(String date) {
    var str = date;
    var parts = str.split(' ');
    var date2 = parts.sublist(1).join(' ');
    return date2;
  }
}
