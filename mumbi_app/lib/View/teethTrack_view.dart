import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/View/teethDetail_view.dart';

class TrackTeeth extends StatefulWidget {
  const TrackTeeth({Key key}) : super(key: key);

  @override
  _TrackTeethState createState() => _TrackTeethState();
}

class _TrackTeethState extends State<TrackTeeth> {
  // List<CustomerModel> customers = <CustomerModel>[];
  bool _flag =true;
  bool _flag2 =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi mọc răng'),
        actions: [
          Container(
            child: IconButton(
              icon: Image.asset(ic_tooth),
              onPressed: () => {},),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GestureDetector(
        onTap: () => {

        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon( Icons.assignment_ind_sharp)),
                  title: Text("Nguyễn Thị Bống"),
                  onTap: () => {},
                  trailing: Icon( Icons.keyboard_arrow_down_outlined),
                ),
              ),
              Stack(
                children: <Widget>[

                  // Răng hàm trên
                  Container(child: Image.asset(img_hamtren, width: 302, height: 189)),

                  // Răng 1
                  Positioned(
                    height: 85, width: 85,top: 100, left: -2,
                    child: Container(
                      child: IconButton(
                        icon: Image.asset(_flag ? ic_teeth1 : ic_teeth1_choose ),
                        onPressed: () =>
                            setState(() => _flag = !_flag),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 85, width: 85,top: 60, left: 10,
                    child: Container(
                      child: IconButton(
                        icon: Image.asset(_flag2 ? ic_teeth2 : ic_teeth2_choose ),
                        onPressed: () =>
                            setState(() => _flag2 = !_flag2),
                      ),
                    ),
                  ),



                ],
              ),
              // Răng hàm dưới
              Container(child: Image.asset(img_hamduoi, width: 302, height: 189)),
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
