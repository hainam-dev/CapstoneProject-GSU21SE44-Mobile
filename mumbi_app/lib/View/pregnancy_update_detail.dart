import 'package:flutter/material.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

class PregnancyUpdate extends StatefulWidget {
  const PregnancyUpdate({Key key}) : super(key: key);

  @override
  _PregnancyUpdateState createState() => _PregnancyUpdateState();
}

class _PregnancyUpdateState extends State<PregnancyUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật thông tin thai kì'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only( left: 16, right: 16),

          child: Update(),
        ),
      ),
    );
  }
}

class Update extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: <Widget>[
        createTextFeild('Tuần thai',"","",(){}),
        createTextFeild('Cân nặng của mẹ (kg)',"","",(){}),
        createTextFeild('Cân nặng thai nhi (kg)',"","",(){}),
        createTextFeild('Đường kính vòng đầu (cm)',"","",(){}),
        createTextFeild('Nhịp tim thai ( /phút)',"","",(){}),
        createTextFeild('Chiều dài xương đùi (cm)',"","",(){}),
        Container(
          margin: EdgeInsets.only(top: 200, left: 16),
          child: Row(
            children: <Widget>[
              createButtonCancel(context,'Hủy', context.widget),
              createButtonConfirm('Lưu thông tin',(){})
            ],
          ),
        )
      ]),
    );
  }
}
