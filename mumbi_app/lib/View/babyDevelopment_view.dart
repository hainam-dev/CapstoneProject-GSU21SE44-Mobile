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
import 'package:mumbi_app/View/childOtherInfo_view.dart';
import 'package:mumbi_app/View/tracking_view.dart';
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
  List<ChildHistoryModel> listChildHistory;
  List<StandardIndexModel> listStandardIndex;

  ChildModel childModel;
  ChildViewModel childViewModel;
  StandardIndexViewModel standardIndexViewModel;
  ChildHistoryViewModel childHistoryViewModel;

  ActionViewModel actionViewModel;
  List<ActionModel> listActFine;
  List<ActionModel> listActGross;

  double weightPercent = 0;
  double heightPercent = 0;
  double headPercent = 0;

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

    resultChildWeight.clear();
    resultChildHeight.clear();
    resultChildHead.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi bé'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(),
            buildChart(),
            buildDevelopmentMilestone(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Container(
          child: ScopedModel(
            model: childViewModel,
            child: ScopedModelDescendant(
              builder: (BuildContext context, Widget child,
                  ChildViewModel modelChild) {
                childModel = modelChild.childModel;
                if (childModel == null) {
                  return Text(
                      "Vui lòng thêm thai kỳ hoặc bé để sử dụng chức năng theo dõi sức khỏe!");
                }
                storage.write(key: childIdKey, value: childModel.id);
                getChild();
                return createListTileDetail(name, day.toString(), imageUrl);
              },
            ),
          ),
        ),
        ScopedModel(
          model: childViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ChildViewModel model) {
              String dateNow = "Ngày " +
                  DateTime.now().day.toString() +
                  " Tháng " +
                  DateTime.now().month.toString() +
                  " Năm " +
                  DateTime.now().year.toString();
              return createListTileNext(context, dateNow,
                  'Cập nhật dữ liệu cho bé', ChildInfoUpdate());
            },
          ),
        ),
      ],
    );
  }

  Widget buildChart() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      color: Colors.white,
      child: ScopedModel(
        model: childHistoryViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child,
              ChildHistoryViewModel modelChild) {
            listChildHistory = modelChild.childListHistoryChild;
            if (listChildHistory?.isNotEmpty ?? false) {
              curentBMI = DateTimeConvert.caculateBMI(
                  listChildHistory.last.weight, listChildHistory.last.height);
              status = DateTimeConvert.caculateBMIdata(
                  listChildHistory.last.weight, listChildHistory.last.height);
              resultChildWeight.clear();
              resultChildHeight.clear();
              resultChildHead.clear();
              for (var childHistory in listChildHistory) {
                if (childHistory.date != null) {
                  final date = DateTimeConvert.calculateChildMonth(
                      childHistory.date,
                      DateFormat("dd/MM/yyyy").parse(childModel.birthday));
                  print('date' + date.toString());
                  resultChildWeight
                      .add(new ChildDataModel(date, childHistory.weight));
                  resultChildHeight
                      .add(new ChildDataModel(date, childHistory.height));
                  resultChildHead.add(
                      new ChildDataModel(date, childHistory.headCircumference));
                }
              }
              print('resultChildWeight' + resultChildWeight.length.toString());
            } else if (listChildHistory?.isEmpty ?? false) {
              curentBMI = 0;
              status = "Vui lòng cập nhật dữ liệu!";
              resultChildWeight = [];
              resultChildWeight = [];
              resultChildWeight = [];
            }
            return ScopedModel<StandardIndexViewModel>(
              model: standardIndexViewModel,
              child: ScopedModelDescendant<StandardIndexViewModel>(
                builder: (context, child, modelStand) {
                  listStandardIndex = modelStand.listStandIndex;
                  List<String> listType = ["Weight", "Height", "Head"];

                  listStandardIndex == null
                      ? loadingProgress()
                      : result = {
                          for (var type in listType)
                            type: listStandardIndex
                                .where((data) => data.type == type)
                        };
                  if (result != null &&
                      (listChildHistory?.isNotEmpty ?? false)) {
                    Iterable<StandardIndexModel> weightList = result["Weight"];
                    Iterable<StandardIndexModel> heightList = result["Height"];
                    Iterable<StandardIndexModel> headList = result["Head"];
                    final date = DateTimeConvert.calculateChildMonth(
                        modelChild.childListHistoryChild.last.date,
                        DateFormat("dd/MM/yyyy").parse(childModel.birthday));
                    for (var index in weightList) {
                      if (index.month.toString() == date.toString()) {
                        double weight = converData(
                            listChildHistory.last.weight.toDouble(),
                            index.maxValue,
                            index.minValue);
                        weightPercent = (weight - index.minValue) /
                            (index.maxValue - index.minValue);
                      }
                    }
                    for (var index in heightList) {
                      double height;
                      if (listChildHistory.isNotEmpty) {
                        height = converData(
                            listChildHistory.last.height.toDouble(),
                            index.maxValue,
                            index.minValue);
                        print('chay 1');
                      } else if (listChildHistory.isEmpty) {
                        print('height = 0;');
                        height = index.minValue;
                      }
                      if (index.month.toString() == date.toString()) {
                        heightPercent = (height - index.minValue) /
                            (index.maxValue - index.minValue);
                      }
                    }
                    for (var index in headList) {
                      double head = converData(
                          listChildHistory.last.headCircumference.toDouble(),
                          index.maxValue,
                          index.minValue);
                      if (index.month.toString() == date.toString()) {
                        headPercent = (head - index.minValue) /
                            (index.maxValue - index.minValue);
                      }
                    }
                  }
                  String dataWeight;
                  String dataHeight;
                  String dataHead;
                  if (weightPercent != null) {
                    weightPercent *= 100;
                    dataWeight = weightPercent.floor().toString();
                  }
                  if (heightPercent != null) {
                    heightPercent *= 100;
                    dataHeight = heightPercent.floor().toString();
                  }
                  if (headPercent != null) {
                    headPercent *= 100;
                    dataHead = headPercent.floor().toString();
                  }
                  return Column(
                    children: <Widget>[
                      //Thể trạng của bé
                      createBabyCondition(
                        context,
                        curentBMI.toString(),
                        status,
                      ),
                      result == null || resultChildWeight == null
                          ? loadingProgress()
                          : Container(
                              child: new Column(children: <Widget>[
                              new SizedBox(
                                  height: 350.0,
                                  child: StackedAreaLineChart.withSampleData(
                                      "Cân nặng",
                                      "Bé nặng hơn $dataWeight% trẻ ",
                                      result["Weight"],
                                      resultChildWeight)),
                            ])),
                      result == null || resultChildHeight == null
                          ? loadingProgress()
                          : new SizedBox(
                              height: 350.0,
                              child: StackedAreaLineChart.withSampleData(
                                  "Chiều cao",
                                  "Bé cao hơn $dataHeight% trẻ ",
                                  result["Height"],
                                  resultChildHeight)),
                      result == null || resultChildHead == null
                          ? loadingProgress()
                          : new SizedBox(
                              height: 350.0,
                              child: StackedAreaLineChart.withSampleData(
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
    );
  }

  Widget buildDevelopmentMilestone() {
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
          ScopedModel<ActionViewModel>(
            model: actionViewModel,
            child: ScopedModelDescendant<ActionViewModel>(
              builder: (context, child, model) {
                List<ActionModel> listAll = model.listAllAction;
                List<ActionModel> listGross = model.listGross;
                double percentGross = 0;
                if (listAll != null && listGross != null) {
                  for (var child in listGross)
                    for (var all in listAll) {
                      if (all.id == child.id && all.checkedFlag == true)
                        percentGross++;
                    }
                  percentGross = percentGross / (listGross.length);
                }
                return createLinear("Vận động thô", percentGross, Colors.green);
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
                if (listAll != null && listFine != null) {
                  for (var child in listFine)
                    for (var all in listAll) {
                      if (all.id == child.id && all.checkedFlag == true)
                        resultFine++;
                    }
                  percentFine = resultFine / (listFine.length);
                }
                return createLinear(
                    "Vận động tinh", percentFine, Colors.orange);
              },
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 16),
              child: createFlatButton(
                  context, 'Cập nhật sự vận động của bé', ActivityDetail())),
        ],
      ),
    );
  }

  getChild() async {
    if (childModel != null) {
      if (childModel.gender != null)
        await storage.write(
            key: childGenderKey, value: childModel.gender.toString());
      name = childModel.fullName;
      birthday = childModel.birthday;
      if (birthday != null) {
        day = DateTimeConvert.calculateChildAge(birthday);
      } else {
        day =
            "Bạn còn ${DateTimeConvert.dayUntil(childModel.estimatedBornDate)} ngày để gặp được bé";
      }

      imageUrl = childModel.imageURL;
    }
  }
}

num converData(double weightData, double maxValue, double minValue) {
  double weight = weightData;
  if (weight >= maxValue)
    weight = maxValue;
  else if (weight <= minValue) weight = minValue;
  return weight;
}
