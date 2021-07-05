// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/View/teethDetail_view.dart';
import 'package:mumbi_app/View/teethProcess.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:mumbi_app/Model/teeth_model.dart';


class TrackTeeth extends StatefulWidget {
  const TrackTeeth({Key key}) : super(key: key);

  @override
  _TrackTeethState createState() => _TrackTeethState();
}

class _TrackTeethState extends State<TrackTeeth> {
  // List<CustomerModel> customers = <CustomerModel>[];
  bool _choose =false;
  bool _flag1 =false;
  bool _flag2 =false;
  bool _flag3 =true;
  bool _flag4 =true;
  bool _flag5 =true;
  bool _flag6 =true;
  bool _flag7 =true;
  bool _flag8 =true;
  bool _flag9 =true;
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

  int positon;
  int lastPress = 0;
  List<bool> chooseDate = List.generate(10, (index) => false);
  List<int> _list = List.generate(10, (index) => index);
  List<TeethModel> listTeeth = <TeethModel>[];

  void chooseTeeth(){

  }
  // List<Widget> listTeeth(int index){
  //   return selectedWidget[(index==0) && []];
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTeeth = getListTeeth();

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
      body: GestureDetector(
        onTap: () => {
          _choose = !_choose
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: createListTile('Nguyễn Thị Bống')
              ),
              Stack(
                children: <Widget>[

                  // Răng hàm trên
                  Container(child: SvgPicture.asset(img_hamtren, width: 302, height: 189)),
                  //stateless
                  createTeeth(ic_teeth1_ht,ic_teeth1_ht_choose,!_choose)



                ],
              ),
              // Răng hàm dưới
              Container(child: SvgPicture.asset(img_hamduoi, width: 302, height: 189)),
              //

              //Thông tin
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(16),
                decoration: new BoxDecoration(
                 color: Colors.white
                ),
                    child: Column(
                      children: <Widget> [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Thông tin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Răng số 10", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Thời gian mọc: 25 - 33 tháng tuổi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
                      ],
                    ),
              ),

              //Bé của bạn
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 16,right: 16),
                decoration: new BoxDecoration(
                    color: Colors.white
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Bé của bạn (Bé Bông):", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Trạng thái: Chưa mọc", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Ngày mọc: --", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(onPressed: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeethDetail()),
                        )
                        },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
                          ),
                          child: Text('Cập nhật'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
