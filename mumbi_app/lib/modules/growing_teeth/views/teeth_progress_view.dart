import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/main.dart';
import 'package:mumbi_app/modules/family/models/child_model.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/modules/growing_teeth/models/teeth_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/modules/growing_teeth/viewmodel/teeth_viewmodel.dart';
import 'package:mumbi_app/widgets/customComponents.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:mumbi_app/widgets/customTimeLineTile.dart';
import 'package:scoped_model/scoped_model.dart';

class TeethProgress extends StatefulWidget {
  const TeethProgress({Key key}) : super(key: key);

  @override
  _TeethProgressState createState() => _TeethProgressState();
}

class _TeethProgressState extends State<TeethProgress> {
  List<TeethModel> listTooth;
  TeethViewModel teethViewModel;
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

    teethViewModel = TeethViewModel.getInstance();
    teethViewModel.getAllToothByChildId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quá trình mọc răng'),
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
              model: teethViewModel,
              child: ScopedModelDescendant<TeethViewModel>(
                builder: (context, child, model) {
                  listTooth = model.listTooth;
                  listTooth.sort((a, b) =>
                      b.grownDate.toString().compareTo(a.grownDate.toString()));
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
