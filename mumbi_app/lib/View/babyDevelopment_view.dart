import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Model/childHistory_model.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/ViewModel/childHistory_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/standardIndex_viewModel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/stacked.dart';
import 'package:mumbi_app/View/activityDetailBaby_update.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Widget/customBabyDevelopment.dart';

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
  List<ChildDataModel> resultChildWeight = <ChildDataModel>[];
  List<ChildDataModel> resultChildHeight = <ChildDataModel>[];
  List<ChildDataModel> resultChildHead = <ChildDataModel>[];

  ChildModel childModel;
  ChildViewModel childViewModel;
  StandardIndexViewModel standardIndexViewModel;
  List<ChildHistoryModel> listChild;

  ChildHistoryViewModel childHistoryViewModel;
  ActionViewModel actionViewModel;
  List<ActionModel> listActFine;
  List<ActionModel> listActGross;
  double weightPercent;
  double heightPercent;
  double headPercent;

  @override
  void initState() {
    super.initState();

    childViewModel = ChildViewModel.getInstance();
    if (CurrentMember.pregnancyFlag == true) {
      childViewModel.getChildByID(CurrentMember.pregnancyID);
    } else {
      childViewModel.getChildByID(CurrentMember.id);
    }

    standardIndexViewModel = StandardIndexViewModel.getInstance();
    standardIndexViewModel.getAllStandard();

    childHistoryViewModel = ChildHistoryViewModel.getInstance();
    childHistoryViewModel.getListChildHistory();

    actionViewModel = ActionViewModel.getInstance();

    actionViewModel.getActionGross();

    actionViewModel.getActionFine();

    actionViewModel.getAllActionByChildId();

    getChild();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi bé'),
        leading: backButton(context, BotNavBar())
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
                                  storage.write(
                                      key: childIdKey, value: childModel.id);
                                  if (childModel == null) {
                                    return loadingProgress();
                                  }
                                  getChild();
                                  return createListTileDetail(
                                      name, day.toString(), imageUrl);
                                },
                              ))),
                      // ScopedModel(
                      //     //todo
                      //     model: childViewModel,
                      //     child: ScopedModelDescendant(
                      //       builder: (BuildContext context, Widget child,
                      //           ChildViewModel model) {
                      //         return createListTileNext(
                      //             context,
                      //             ' 21/05/2021',
                      //             'Ngày tiêm chủng sắp tới:',
                      //             InjectionSchedule());
                      //       },
                      //     )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    color: Colors.white,
                    child: ScopedModel(
                      model: childHistoryViewModel,
                      child: ScopedModelDescendant(
                        builder: (BuildContext context, Widget child, ChildHistoryViewModel modelChild) {
                          listChild = modelChild.childListHistoryChild;
                          if (listChild?.isNotEmpty ?? false) {
                            // listChild.forEach((e) => e.date = DateTimeConvert.calculateChildMonth(e.date));
                            curentBMI = DateTimeConvert.caculateBMI(listChild.last.weight, listChild.last.height);
                            status = DateTimeConvert.caculateBMIdata(listChild.last.weight, listChild.last.height);
                            resultChildWeight.clear();
                            resultChildHeight.clear();
                            resultChildHead.clear();
                            for (var child in listChild) {
                              if (child.date != null) {
                                final date = DateTimeConvert.calculateChildMonth(child.date,DateFormat("dd/MM/yyyy").parse(childModel.birthday));
                                print('date'+date.toString());
                                resultChildWeight.add(new ChildDataModel(date, child.weight));
                                resultChildHeight.add(new ChildDataModel(date, child.height));
                                resultChildHead.add(new ChildDataModel(date, child.headCircumference));
                              }
                            }
                            print('resultChildWeight'+resultChildWeight.length.toString());
                          }
                          return ScopedModel<StandardIndexViewModel>(
                            model: standardIndexViewModel,
                            child:
                                ScopedModelDescendant<StandardIndexViewModel>(
                              builder: (context, child, modelStand) {
                                List<StandardIndexModel> list = modelStand.listStandIndex;
                                List<String> listType = ["Weight", "Height", "Head"];

                                list == null || listChild == null
                                    ? loadingProgress()
                                    : result = {
                                        for (var type in listType)
                                          type: list.where(
                                              (data) => data.type == type)
                                      };
                                if(result != null && (listChild?.isNotEmpty ?? false))
                                  {
                                    Iterable<StandardIndexModel> weightList = result["Weight"];
                                    Iterable<StandardIndexModel> heightList = result["Height"];
                                    Iterable<StandardIndexModel> headList = result["Head"];
                                    final date = DateTimeConvert.calculateChildMonth(modelChild.childListHistoryChild.last.date,DateFormat("dd/MM/yyyy").parse(childModel.birthday));
                                    for (var index in weightList)
                                    {
                                      if(index.month.toString() == date.toString())
                                      {
                                        double weight = converData(listChild.last.weight.toDouble(), index.maxValue, index.minValue);
                                        weightPercent = (weight - index.minValue)/(index.maxValue - index.minValue);
                                      }
                                    }
                                    for (var index in heightList)
                                    {
                                      double height = converData(listChild.last.height.toDouble(), index.maxValue, index.minValue);
                                      if(index.month.toString() == date.toString())
                                      {
                                        heightPercent = (height - index.minValue)/(index.maxValue - index.minValue);
                                      }
                                    }
                                    for (var index in headList)
                                    {
                                      double head = converData(listChild.last.headCircumference.toDouble(), index.maxValue, index.minValue);
                                      if(index.month.toString() == date.toString())
                                      {
                                        headPercent = (head - index.minValue)/(index.maxValue - index.minValue);
                                      }
                                    }
                                  }
                                String dataWeight;
                                String dataHeight;
                                String dataHead;
                                if(weightPercent!= null){
                                  weightPercent*=100;
                                  dataWeight = weightPercent.floor().toString();
                                }
                                if(heightPercent!= null){
                                  heightPercent*=100;
                                  dataHeight = heightPercent.floor().toString();
                                }
                                if(headPercent!= null){
                                  headPercent*=100;
                                  dataHead = headPercent.floor().toString();
                                }
                                return Column(
                                  children: <Widget>[
                                    //Thể trạng của bé
                                    curentBMI == null || status == ""
                                        ? loadingProgress()
                                        : createBabyCondition(context,
                                              status, curentBMI.toString(),),
                                    result == null || resultChildWeight == null
                                        ? loadingProgress()
                                        : Container(
                                            child: new Column(
                                            children: <Widget>[
                                            new SizedBox(
                                                height: 350.0,
                                                child: StackedAreaLineChart
                                                    .withSampleData(
                                                        "Cân nặng",
                                                        "Bé nặng hơn $dataWeight% trẻ ",
                                                        result["Weight"],
                                                        resultChildWeight)),
                                          ])),
                                    result == null || resultChildHeight == null
                                        ? loadingProgress()
                                        : new SizedBox(
                                            height: 350.0,
                                            child: StackedAreaLineChart
                                                .withSampleData(
                                                    "Chiều cao",
                                                    "Bé cao hơn $dataHeight% trẻ ",
                                                    result["Height"],
                                                    resultChildHeight)),
                                    result == null || resultChildHead == null
                                        ? loadingProgress()
                                        : new SizedBox(
                                            height: 350.0,
                                            child: StackedAreaLineChart
                                                .withSampleData(
                                                    "Chu vi đầu",
                                                    "Bé có chu vi đầu lớn hơn $dataHead% trẻ cùng lứa",
                                                    result["Head"],
                                                    resultChildHead)),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 16),
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Mốc phát triển',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Bé của bạn đã có tiến bộ gì hơn chưa? ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                      ScopedModel<ActionViewModel>(
                        model: actionViewModel,
                        child: ScopedModelDescendant<ActionViewModel>(
                          builder: (context, child, model) {
                            List<ActionModel> listAll = model.listAllAction;
                            List<ActionModel> listGross = model.listGross;
                            double percentGross = 0;
                            if(listAll != null && listGross != null)
                              {
                                  for (var child in listGross)
                                    for (var all in listAll)
                                    {
                                      if(all.id == child.id && all.checkedFlag == true)
                                        percentGross++;
                                    }
                                percentGross = percentGross/(listGross.length);
                              }
                            return createLinear(
                                "Vận động thô", percentGross, Colors.green);
                          },
                        ),
                      ),
                      ScopedModel<ActionViewModel>(
                        model: actionViewModel,
                        child: ScopedModelDescendant<ActionViewModel>(
                          builder: (context, child, model) {
                            List<ActionModel> listAll = model.listAllAction;
                            List<ActionModel> listFine = model.listFine;
                            double percentFine = 0;
                            int resultFine = 0;
                            if(listAll != null && listFine != null)
                            {
                              for (var child in listFine)
                                for (var all in listAll)
                                {
                                  if(all.id == child.id && all.checkedFlag == true)
                                    resultFine++;
                                }
                              percentFine = resultFine/(listFine.length);
                            }
                            return createLinear(
                                "Vận động tinh", percentFine, Colors.orange);
                          },
                        ),
                      ),

                      Container(
                          padding: EdgeInsets.only(top: 16),
                          child: createFlatButton(context,
                              'Cập nhật sự vận động của bé', ActivityDetail())),
                    ],
                  )),
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
    if (childModel != null) {
      if (childModel.gender != null)
        await storage.write(
            key: childGenderKey, value: childModel.gender.toString());
      name = childModel.fullName;
      birthday = childModel.birthday;
      imageUrl = childModel.imageURL;

      day = DateTimeConvert.calculateChildAge(birthday);
    }
  }
}

num converData(double weightData, double maxValue, double minValue) {
  double weight = weightData;
  if(weight >= maxValue)
    weight = maxValue*0.99;
  else if(weight <= minValue)
    weight = minValue*0.99;
  return weight;
}

