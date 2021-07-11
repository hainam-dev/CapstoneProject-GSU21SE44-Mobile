import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/View/teethDetail_view.dart';
import 'package:mumbi_app/View/teethProcess.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:mumbi_app/Model/teeth_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/ViewModel/teeth_viewmodel.dart';
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

  String ht_teeth1= ic_teeth1_ht;
  String ht_teeth2= ic_teeth2_ht;
  String ht_teeth3= ic_teeth3_ht;
  String ht_teeth4= ic_teeth4_ht;
  String ht_teeth5= ic_teeth5_ht;
  String ht_teeth6= ic_teeth6_ht;
  String ht_teeth7= ic_teeth7_ht;
  String ht_teeth8= ic_teeth8_ht;

  int lastPositon = 0;
  List<bool> _flag = List.generate(20, (index) => false);
  List<int> _list = List.generate(20, (index) => index);
  bool isChose = false;
  int position;

  List<TeethModel> listTeeth;

  final children = Widget;
  final listChid = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
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
          child: ScopedModel(
            model: TeethViewModel.getInstance(),
            child: ScopedModelDescendant(
              builder: (BuildContext context,Widget child,TeethViewModel model)
              {
                return Column(
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.all(18),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                        ),
                        child: createListTile('Nguyễn Thị Bống')
                    ),
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
                                     storage.write(key: teethKey, value: (position+1).toString());
                                     await model.getTeethById();
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
                            storage.write(key: teethKey, value: (position+1).toString());
                            await model.getTeethById();
                            setState(()  {});
                          }
                          )
                      ],
                    ),

                    !isChose ? Container()
                      :Column(
                      children: <Widget>[
                        //Thông tin
                        createTextAlignInformation(model.teethModel.position.toString(),model.teethModel.name,model.teethModel.growTime),
                        //Bé của bạn
                        createTextAlignUpdate(context, model.teethModel.position.toString(),model.teethModel.name,model.teethModel.growTime, TeethDetail("Thông tin","Create")),
                      ],
                    )
                  ],
                );
              }
            ),
          ),
        )
    );
  }
}
