import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Model/childHistory_model.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
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
  List<ChildDataModel>  resultChildHeight = <ChildDataModel>[];
  List<ChildDataModel>  resultChildHead = <ChildDataModel>[];

  ChildModel childModel;
  ChildViewModel childViewModel;
  StandardIndexViewModel standardIndexViewModel;
  List<ChildHistoryModel> listHisChild;

  ChildHistoryViewModel childHistoryViewModel;
  ActionViewModel actionViewModel;

  @override
  void initState() {
    super.initState();

    childViewModel = ChildViewModel.getInstance();
    if(CurrentMember.pregnancyFlag == true){
      childViewModel.getChildByID(CurrentMember.pregnancyID);
    }else{
      childViewModel.getChildByID(CurrentMember.id);
    }

    standardIndexViewModel = StandardIndexViewModel.getInstance();
    standardIndexViewModel.getAllStandard();

    childHistoryViewModel = ChildHistoryViewModel.getInstance();
    childHistoryViewModel.getListChildHistory();
    listHisChild = childHistoryViewModel.childListHistoryChild;

    actionViewModel = ActionViewModel.getInstance();
    actionViewModel.getActionByType("Thô");
    actionViewModel.getAllActionByChildId();


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
                    child: ScopedModel<ChildHistoryViewModel>(
                      model: childHistoryViewModel,
                      child: ScopedModelDescendant<ChildHistoryViewModel>(
                        builder: (context, child, modelChild){
                          listHisChild.forEach((e) => e.date = DateTimeConvert.calculateChildMonth(e.date));
                          curentBMI = DateTimeConvert.caculateBMI(listHisChild.first.weight, listHisChild.first.height);
                          status = DateTimeConvert.caculateBMIdata(listHisChild.first.weight, listHisChild.first.height);
                          for(var child in listHisChild)
                            {
                              if(child.date != null)
                                {
                                  resultChildWeight.add(new ChildDataModel(child.date, child.weight));
                                  resultChildHeight.add(new ChildDataModel(child.date, child.height));
                                  resultChildHead.add(new ChildDataModel(child.date, child.headCircumference));
                                }
                            }
                          return ScopedModel<StandardIndexViewModel>(
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
                                                  "Cân nặng", "Bé nặng hơn 30% trẻ ",result["Weight"], resultChildWeight)),
                                        ])),
                                    result == null
                                        ? loadingProgress()
                                        : new SizedBox(
                                        height: 350.0,
                                        child: StackedAreaLineChart.withSampleData(
                                            "Chiều cao", "Bé cao hơn 30% trẻ ", result["Height"], resultChildHeight)),
                                    result == null
                                        ? loadingProgress()
                                        : new SizedBox(
                                        height: 350.0,
                                        child: StackedAreaLineChart.withSampleData(
                                            "Chu vi đầu",
                                            "Bé có chu vi đầu lớn hơn 30% trẻ cùng lứa",  result["Head"], resultChildHead)),
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
                          builder: (context, child, model){
                            List<ActionModel> listType = model.list;
                            List<ActionModel> list = model.listAllAction;
                            var result = {
                              for (var month in list )
                                month: listType.where((data) => data.month == month)
                            };
                            double percent = result.length/listType.length;
                            return createLinear("Vận động thô", percent, Colors.green);
                          },
                        ),
                      ),
                      createLinear("Vận động tinh", 0.5, Colors.orange),
                      Container(
                          padding: EdgeInsets.only(top: 16),
                          child: createFlatButton(
                              context, 'Cập nhật sự vận động của bé', ActivityDetail())),
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
    if(childModel != null) {
      if (childModel.gender != null)
        var childGender = await storage.write(
            key: childGenderKey, value: childModel.gender.toString());
      name = childModel.fullName;
      birthday = childModel.birthday;
      imageUrl = childModel.imageURL;

      day = DateTimeConvert.calculateChildBorn(birthday);
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
            ScopedModel(
              model: ActionViewModel.getInstance(),
              child: ScopedModelDescendant<ActionViewModel>(
                builder: (context, child, model){
                  model.getAllActionByChildId();
                  return createLinear("Vận động thô", 0.5, Colors.green);
                },
              ),
            ),
            createLinear("Vận động tinh", 0.5, Colors.orange),
            Container(
                padding: EdgeInsets.only(top: 16),
                child: createFlatButton(
                    context, 'Cập nhật sự vận động của bé', ActivityDetail())),
          ],
        ));
  }
}
