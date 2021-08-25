import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Widget/customTimeLineTile.dart';

import '../main.dart';

class TeethProcess extends StatefulWidget {
  const TeethProcess({Key key}) : super(key: key);

  @override
  _TeethProcessState createState() => _TeethProcessState();
}

class _TeethProcessState extends State<TeethProcess> {
  List<ToothModel> listTooth;
  ToothViewModel toothViewModel;
  ChildViewModel childViewModel;
  ChildModel childModel;
  String name = "", birthday = "", imageUrl = "", day = "", status = "";

  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();
    if (CurrentMember.pregnancyFlag == true) {
      childViewModel.getChildByID(CurrentMember.pregnancyID);
    } else {
      childViewModel.getChildByID(CurrentMember.id);
    }

    toothViewModel = ToothViewModel.getInstance();
    toothViewModel.getAllToothByChildId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quá trình mọc răng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ScopedModel(
              model: childViewModel,
              child: ScopedModelDescendant(
                builder: (BuildContext context, Widget child,
                    ChildViewModel modelChild) {
                  childModel = modelChild.childModel;
                  storage.write(key: childIdKey, value: childModel.id);
                  if (childModel == null) {
                    return loadingProgress();
                  }
                  getChild();
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: createListTileDetail(name, day.toString(), imageUrl),
                  );
                },
              ),
            ),
            ScopedModel(
              model: toothViewModel,
              child: ScopedModelDescendant<ToothViewModel>(
                builder: (context, child, model) {
                  listTooth = model.listTooth;
                  listTooth.sort(
                          (a, b) => b.grownDate.toString().compareTo(a.grownDate.toString()));
                  listTooth.reversed;
                  return listTooth.isEmpty
                      ? Center(
                          child: Text("Chưa có dữ liệu mọc răng của bé.\n"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: listTooth.length,
                          itemBuilder: (BuildContext context, index) {
                            if (index == 0) {
                              return firstTimeLineTile(listTooth.first);
                            }
                            if (index == listTooth.length - 1) {
                              return lastTimeLineTile(listTooth.last);
                            }
                            return customTimeLineTile(listTooth[index]);
                          },
                        );
                },
              ),
            )
          ],
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
        storage.write(key: childGenderKey, value: childModel.gender.toString());
      name = childModel.fullName;
      birthday = childModel.birthday;
      imageUrl = childModel.imageURL;
      try {
        day = DateTimeConvert.calculateChildAge(birthday);
      } catch (e) {
        return "";
      }
    }
  }
}
