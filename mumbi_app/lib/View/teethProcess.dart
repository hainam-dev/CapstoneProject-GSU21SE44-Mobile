                                                                                                 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines/timelines.dart';
import 'package:mumbi_app/Widget/customTimeLineTile.dart';




class TeethProcess extends StatefulWidget {
  const TeethProcess({Key key}) : super(key: key);

  @override
  _TeethProcessState createState() => _TeethProcessState();
}

class _TeethProcessState extends State<TeethProcess> {
  List<ToothModel> listTooth;
  List<ToothInfoModel> listInfo;
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
      body: ScopedModel(
        model: ToothViewModel.getInstance(),
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ToothViewModel model){
            model.getAllToothByChildId();
            listTooth = model.listTooth;
            return listTooth == null
            ? loadingProgress()
            : ScopedModelDescendant(
              builder: (BuildContext context, Widget child, ToothViewModel model){
                return ListView.builder(
                  itemCount: listTooth.length,
                  itemBuilder: (BuildContext context, index){
                    if (index == 0){
                      return firstTimeLineTile(listTooth.first);
                    }
                    if (index == listTooth.length -1){
                      return lastTimeLineTile(listTooth.last);
                    }
                      return customTimeLineTile(listTooth[index]);

                    return null;

                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
