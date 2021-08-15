import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/standardIndex_viewModel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/stacked.dart';
import 'package:mumbi_app/View/activityDetailBaby_update.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Widget/customBabyDevelopment.dart';
import "package:normal/normal.dart";


import '../main.dart';

class BabyDevelopment extends StatefulWidget {
  const BabyDevelopment({Key key}) : super(key: key);

  @override
  _BabyDevelopmentState createState() => _BabyDevelopmentState();
}

class _BabyDevelopmentState extends State<BabyDevelopment> {
  String name = "", birthday = "", imageUrl = "", day = "", status = "";
  var curentBMI = null;
  var result;
  Future<StandardIndexModel> futureStandard;

  ChildModel childModel;
  ChildViewModel childViewModel;
  StandardIndexViewModel standardIndexViewModel;
  List<StandardIndexModel> listStandard;



  @override
  void initState() {
    double i = 3.2;

     double x = (i - 3.2) / 2.8;
     print("Giá tri");
      // print(
      //     "${x.toString().padLeft(4)} |${" " * (p * 40).round()}:${p.toStringAsFixed(4)}");


    super.initState();
    childViewModel = ChildViewModel.getInstance();
    if(CurrentMember.pregnancyFlag == true){
      childViewModel.getChildByID(CurrentMember.pregnancyID);
    }else{
      childViewModel.getChildByID(CurrentMember.id);
    }

    standardIndexViewModel = StandardIndexViewModel.getInstance();
    standardIndexViewModel.getAllStandard();

    // double weight = childModel.weight = 60.0;
    // double height = childModel.height = 1.53;

    double weight = 60.0;
    double height = 1.53;
    num data= weight/(height*height);
    curentBMI = data.floor();
    if (curentBMI < 5) {
      status = "Thiếu cân";
    } else if (curentBMI >= 5 && curentBMI <= 95) {
      status = "Bình thường";
    } else
      status = "Béo phì";
    getChild();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi bé'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          // margin: EdgeInsets.all(18),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ScopedModel(
                              model: childViewModel,
                              child: ScopedModelDescendant(
                                builder: (BuildContext context, Widget child,
                                    ChildViewModel modelChild) {
                                  childModel = modelChild.childModel;
                                  var childKey = storage.write(key: childIdKey, value: childModel.id);
                                  if (childModel == null) {
                                    return loadingProgress();
                                  }
                                  getChild();
                                  return createListTileDetail(
                                      name, day.toString(), imageUrl);
                                },
                              ))),
                      ScopedModel(
                          //todo
                          model: childViewModel,
                          child: ScopedModelDescendant(
                            builder: (BuildContext context, Widget child,
                                ChildViewModel model) {
                              return createListTileNext(
                                  context,
                                  ' 21/05/2021',
                                  'Ngày tiêm chủng sắp tới:',
                                  InjectionSchedule());
                            },
                          )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    color: Colors.white,
                    child: ScopedModel(
                      model: standardIndexViewModel,
                      child: ScopedModelDescendant<StandardIndexViewModel>(
                        builder: (context, child, modelStand) {
                          List<StandardIndexModel> list = modelStand.listStandIndex;
                          List<String> listType = ["Weight", "Height", "Head"];
                          list == null
                          ? loadingProgress()
                          : result = { for (var type in listType) type: list.where((data) => data.type == type) };
                          return Column(
                            children: <Widget>[

                              //Thể trạng của bé
                              curentBMI == null || status == ""
                                  ? loadingProgress()
                                  : createBabyCondition(context,
                                      curentBMI.toString(), status),
                              result == null
                                  ? loadingProgress()
                                  : Container(
                                  child: new Column(children: <Widget>[
                                  new SizedBox(
                                    height: 350.0,
                                    child: StackedAreaLineChart.withSampleData(
                                        "Cân nặng", "Bé nặng hơn 30% trẻ ",result["Weight"])),
                              ])),
                              result == null
                                  ? loadingProgress()
                                  : new SizedBox(
                                  height: 350.0,
                                  child: StackedAreaLineChart.withSampleData(
                                      "Chiều cao", "Bé cao hơn 30% trẻ ", result["Height"])),
                              result == null
                                  ? loadingProgress()
                                  : new SizedBox(
                                  height: 350.0,
                                  child: StackedAreaLineChart.withSampleData(
                                      "Chu vi đầu",
                                      "Bé có chu vi đầu lớn hơn 30% trẻ cùng lứa",  result["Head"])),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              DrawProgress()
            ],
          ),
        ),
      ),
    );
  }

  getChild() async {
    if (imageUrl == null) {
      imageUrl = "";
    }
    if(childModel != null) {
      if (childModel.gender != null)
        var childGender = await storage.write(
            key: childGenderKey, value: childModel.gender.toString());
      name = childModel.fullName;
      birthday = childModel.birthday;
      imageUrl = childModel.imageURL;

      DateTime dayCurrent = DateTime.parse(birthday
          .split('/')
          .reversed
          .join());
      Duration dur = DateTime.now().difference(dayCurrent);
      double durInMoth = dur.inDays / 30;
      double durInDay = dur.inDays / 30 - 12 * dur.inDays / 30 / 12;
      int durDay = (DateTime.now().day - dayCurrent.day);
      if(durDay < 0)
        durDay*=-1;
      if (durInMoth < 12 && durInMoth >= 1) {
        day = durInMoth.floor().toString() +
            " tháng " +
            durDay.toString() +
            " ngày";
      } else if (durInMoth > 12) {
        day = (durInMoth / 12).floor().toString() +
            " năm " + durInDay.floor().toString() +
            " tháng " + durDay.toString() + " ngày";
      } else if (durInMoth > 0) {
        day = durDay.toString() + " ngày";
      } else if (durInMoth < 0) {
        durInMoth *= -1;
        day = "Còn " +
            durInMoth.floor().toString() +
            " tháng " +
            durDay.toString().toString() +
            " ngày bé ra đời";
      }
    }
  }
}

class DrawProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Mốc phát triển',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
            Container(
                padding: EdgeInsets.only(top: 16),
                alignment: Alignment.topLeft,
                child: Text(
                  'Bé của bạn đã có tiến bộ gì hơn chưa? ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                )),
            createLinear("Vận động thô", 1, Colors.green),
            createLinear("Vận động tinh", 0.5, Colors.orange),
            Container(
                padding: EdgeInsets.only(top: 16),
                child: createFlatButton(
                    context, 'Cập nhật sự vận động của bé', ActivityDetail())),
          ],
        ));
  }
}
