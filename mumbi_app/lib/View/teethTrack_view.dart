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
  // List<CustomerModel> customers = <CustomerModel>[];
  bool _choose =false;
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
        body:
    SingleChildScrollView(
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
                            name = modelChild.childListModel[0].fullName;
                            storage.write(key: childId, value: modelChild.childListModel[0].id);
                            return createListTile(modelChild.childListModel[0].imageURL, modelChild.childListModel[0].fullName);
                          },
                        )
                      )
                  ),


      // modelTooth.getToothByChildId();

    // setState(() {
    //
    // });

    Column(
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
                    position = index;
                    String valuePosition = (position+1).toString();
                    storage.write(key: toothInforKey, value: valuePosition);
                    setState(()  {});

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
                  position = index;
                  String valuePosition = (position+1).toString();
                  storage.write(key: toothInforKey, value: valuePosition);
                  print("vi tri rang, toothInforkey: "+ (position+1).toString());
                  setState(()  {});
                }
                )
            ],
          ),

          !isChose ? Container(
            // child: ScopedModel(
            //   model: ToothViewModel.getInstance(),
            //   child: ScopedModelDescendant(
            //       builder: (BuildContext context,Widget child,ToothViewModel model){
            //         model.getToothByChildId();
            //         return createTextAlignUpdate(context,model.toothModel.grownFlag.toString(),model.toothInforModel.growTime, TeethDetail("Thông tin","Create"));
            //
            //       }
            //
            //   ),
            // )
          )

              :Column(
            children: <Widget>[
              // Thông tin
              ScopedModel(
                model: ToothViewModel.getInstance(),
                  child: ScopedModelDescendant(
                    builder: (BuildContext context,Widget child,ToothViewModel modelTooth){
                      modelTooth.getToothInfoById();
                      return createTextAlignInformation(modelTooth.toothInforModel.position.toString(),
                          modelTooth.toothInforModel.name,modelTooth.toothInforModel.growTime);
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
                        if( tooth != null) {
                          status  = "Đã mọc";
                          // print('ahihj'+ DateTime.tryParse(tooth.grownDate).toString());
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
        ])
    // }),

    ],
              )


        )
    );
  }
}
