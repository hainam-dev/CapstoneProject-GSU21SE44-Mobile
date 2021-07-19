import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/View/teethDetail_view.dart';
import 'package:mumbi_app/View/teethProcess.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';
import 'package:mumbi_app/main.dart';


class TeethTrack extends StatefulWidget {
  const TeethTrack({Key key}) : super(key: key);

  @override
  _TeethTrackState createState() => _TeethTrackState();
}

class _TeethTrackState extends State<TeethTrack> {
  bool original = true;
  bool original_and_present = true;

  int lastPositon = 0;
  List<bool> _flag = List.generate(20, (index) => false);
  List<int> _list = List.generate(20, (index) => index);
  bool isChose = false;
  int position;
  String name;
  String status;
  String growTime;

  List<ToothInfoModel> listTeeth;

  final children = Widget;
  final listChid = <Widget>[];

  @override
  void initState() {
    super.initState();
    listTeeth = getListTeeth();
    print("ds rang:" +listTeeth.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Theo dõi mọc răng'),
          actions: [
            Container(
              child: IconButton(
                icon: SvgPicture.asset(ic_tooth),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeethProcess()),
                  ),
                },),
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.all(18),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ScopedModel(
                        model: ChildViewModel.getInstance(),
                        child: ScopedModelDescendant(
                          builder: (BuildContext context,Widget child,ChildViewModel modelChild){
                            modelChild.getChildByMom();
                            if(modelChild.childListModel == null){
                              return loadingProgress();
                            }
                            name = modelChild.childListModel[0].fullName;
                            storage.write(key: childIdKey, value: modelChild.childListModel[0].id);
                            return createListTile(modelChild.childListModel[0].imageURL, modelChild.childListModel[0].fullName);
                          },
                        )
                      )
                  ),
    ScopedModel(
      model: ToothViewModel.getInstance(),
      child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(18),
              child: Stack(
                children:
                <Widget>[
                  Container(child: SvgPicture.asset(img_hamtren, width: 302, height: 189)),
                  for(int index = 0; index < _list.length /2; index++)
                    createTeeth(listTeeth[index], _flag[index], () async {
                      _flag[index] = !_flag[index];
                      if(isChose && lastPositon != index){
                        _flag[lastPositon] = !_flag[lastPositon];
                        lastPositon = index;
                      } else if (isChose && lastPositon == index){
                        lastPositon = null;
                        isChose = false;
                      } else{
                        lastPositon= index;
                        isChose = true;
                      }
                      getPosition(index);
                      setState(() {

                      });
                    }
                    )
                ],
              ),
            ),
            // Răng hàm dưới
            Stack(
              children:
              <Widget>[
                Container(child: SvgPicture.asset(img_hamduoi, width: 302, height: 189)),
                for(int index = 10; index < _list.length; index++)
                  createTeeth(listTeeth[index], _flag[index], () async{
                    _flag[index] = !_flag[index];
                    if(isChose && lastPositon != index){
                      _flag[lastPositon] = !_flag[lastPositon];
                      lastPositon = index;
                    } else if (isChose && lastPositon == index){
                      lastPositon = null;
                      isChose = false;
                    } else{
                      lastPositon= index;
                      isChose = true;
                    }
                    getPosition(index);

                    setState(()  {});
                  }
                  )
              ],
            ),

            !isChose
                ? Container()
                : Column(
              children: <Widget>[
                // Thông tin
                ScopedModel(
                  model: ToothViewModel.getInstance(),
                    child: ScopedModelDescendant(
                      builder: (BuildContext context,Widget child,ToothViewModel modelTooth){
                        modelTooth.getToothInfoById();
                        if(modelTooth.toothInforModel != null){
                          var toothId = storage.write(key: toothIdKey, value: modelTooth.toothInforModel.id);
                          return createTextAlignInformation(modelTooth.toothInforModel.number.toString(),
                              modelTooth.toothInforModel.name,modelTooth.toothInforModel.growTime);
                        }
                        // var toothId = storage.write(key: toothIdKey, value: modelTooth.toothInforModel.id);
                        return createTextAlignInformation("",
                            "","");
                      }
                    )
                ),
                // Bé của bạn
                ScopedModel(
                    model: ToothViewModel.getInstance(),
                    child: ScopedModelDescendant(
                        builder: (BuildContext context,Widget child,ToothViewModel modelTooth){
                          modelTooth.getToothByChildId();
                          ToothModel tooth = modelTooth.toothModel;
                          // print("TOOTH TRACK: "+tooth.childId.toString()+tooth.grownDate.toString());
                          if( tooth != null && tooth.toothId != null) {
                            status  = "Đã mọc";
                            DateTime oDate = DateTime.tryParse(tooth.grownDate.toString());
                            growTime = oDate.day.toString()+"/"+oDate.month.toString() +"/"+ oDate.year.toString();
                          } else{
                            status = "Chưa mọc";
                            growTime = "--";
                          }
                          return createTextAlignUpdate(context,name, status,growTime,
                              TeethDetail("Thông tin","Create"));
                        }
                    )
                ),
              ],
            )
          ]),
          )
        ],)
    )
    );
  }
  void getPosition(int index)async {
    position = index;
    String valuePosition = (position+1).toString();
    storage.write(key: toothPosInfo, value: valuePosition);
  }
}
