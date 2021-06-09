import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class TeethDetail extends StatefulWidget {
  const TeethDetail({Key key}) : super(key: key);

  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mọc răng'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Ngày'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Răng'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Trạng thái(*)'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ghi chú (nếu có)'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hình ảnh',
                      style: TextStyle(color: Colors.pink),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: SizedBox(
                          width: 80,
                          height: 80,
                          child: DottedBorder(
                            strokeCap: StrokeCap.butt,
                            color: Colors.grey,
                            // gap: 3,
                            strokeWidth: 1,
                            child: Center(
                                child: FlatButton(
                                    child: Icon(
                              Icons.add,
                              size: 30,
                            ))),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () => {},
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: Text('Hủy'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: SizedBox(
                          width: 205,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                            child: Text('Cập nhật'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
