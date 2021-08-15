import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/dashboard_view.dart';
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
  List<bool> listGrow = List.generate(20, (index) => false);
  List<bool> _flag = List.generate(20, (index) => false);
  List<int> _list = List.generate(20, (index) => index);
  bool isChose = false;
  int position;
  String name;
  String status;
  String growTime;

  ToothViewModel toothViewModel;
  ChildViewModel childViewModel;
  List<ChildModel> listChild;
  List<ToothInfoModel> listTeeth;
  List<ToothModel> listAllTooth;

  final children = Widget;
  final listChid = <Widget>[];
  int indexTooth = 3;

  @override
  void initState() {
    super.initState();
    listTeeth = getListTeeth();

    childViewModel = ChildViewModel.getInstance();
    childViewModel.getChildByID(CurrentMember.id);

    toothViewModel = ToothViewModel.getInstance();
    toothViewModel.getAllToothByChildId();


    setState(() {

    });
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
          leading: backButton(context, BotNavBar())
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
                        model: childViewModel,
                        child: ScopedModelDescendant<ChildViewModel>(
                          builder: (context,child,modelChild){
                            if(modelChild.childModel == null){
                              return loadingProgress();
                            }
                            name = modelChild.childModel.fullName;
                            storage.write(key: childIdKey, value: modelChild.childModel.id);
                            return createListTile(modelChild.childModel.imageURL, modelChild.childModel.fullName);
                          },
                        )
                      )
                  ),
    ScopedModel(
      model: toothViewModel,
      child: ScopedModelDescendant<ToothViewModel>(
        builder: (context, child, model){
          listAllTooth = toothViewModel.listTooth;
          if(listAllTooth != null )for(int i = 0; i < listAllTooth.length; i++){
            if(listAllTooth[i].grownFlag){
              listGrow[int.tryParse(listAllTooth[i].toothId)-1] = true;
            }
          }
          return Column(
              children: <Widget>[
                // Răng hàm trên
                Stack(
                  children:
                  <Widget>[
                    Container(child: SvgPicture.asset(img_hamtren, width: 302, height: 189)),
                    for(int index = 0; index < _list.length /2; index++)
                      createTeeth(listTeeth[index], (_flag[index] || listGrow[index]), () async {
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
                        print("Chạy nút");
                        getPosition(index);
                        toothViewModel.getToothInfoById();
                        // toothViewModel.getToothByChildId();
                        setState(() {});
                      }
                      )
                  ],
                ),
                // Răng hàm dưới
                Stack(
                  children:
                  <Widget>[
                    Container(child: SvgPicture.asset(img_hamduoi, width: 302, height: 189)),
                    for(int index = 10; index < _list.length; index++)
                      createTeeth(listTeeth[index], _flag[index]|| listGrow[index], () async{
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
                        toothViewModel.getToothInfoById();

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
                        ScopedModelDescendant<ToothViewModel>(
                            builder: (context, child, modelTooth){
                              if(modelTooth.toothInforModel != null){
                                return createTextAlignInformation(modelTooth.toothInforModel.number.toString(),
                                    modelTooth.toothInforModel.name,modelTooth.toothInforModel.growTime);
                              }
                              return createTextAlignInformation("",
                                  "","");
                            }
                        ),
                        // Bé của bạn
                        ScopedModelDescendant<ToothViewModel>(
                            builder: (context,child,modelTooth){
                              ToothModel tooth = modelTooth.toothModel;
                              if( tooth != null && tooth.toothId != null && tooth.grownFlag == true) {
                                status  = "Đã mọc";
                                DateTime oDate = DateTime.tryParse(tooth.grownDate.toString());
                                growTime = oDate.day.toString()+"/"+oDate.month.toString() +"/"+ oDate.year.toString();
                              } else{
                                status = "Chưa mọc";
                                growTime = "--";
                              }
                              if(tooth == null || name == null)
                                return loadingProgress();
                              return createTextAlignUpdate(context,name, status,growTime,
                                  TeethDetail());
                            }
                        ),
                      ],
                    )
              ]);
            },
          ),
          )
        ],)
    )
    );
  }
  void getPosition(int index)async {
    position = index;
    String valuePosition = (position+1).toString();
    var key = await storage.write(key: toothPosInfo, value: valuePosition);
  }
}
