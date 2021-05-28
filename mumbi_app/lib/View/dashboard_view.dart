import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'Drawer.dart';
import 'changeAccount_view.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  final List _listNews = [
    'https://image.winudf.com/v2/image/Y29tLmJta3NzZXJ2aWNlcy5tb21hbmRiYWJ5d2FsbHBhcGVyc2hkX3NjcmVlbl84XzE1NDAwOTcwMDRfMDUy/screen-8.jpg?fakeurl=1&type=.jpg',
    'https://ehospice.com/wp-content/uploads/2018/07/5b815c14d2e7c6a76e0d161c0f70d6a1-1-770x500.jpg',
    'https://images.ctfassets.net/9l3tjzgyn9gr/photo-226873/ddfbba301f774e587ad73311d1c15368/226873-mom-and-baby.jpg?fm=jpg&fl=progressive&q=50&w=1200',
    'https://femina.wwmindia.com/content/2020/jul/baby61009062xl1594802348.jpg',
    'https://image.freepik.com/free-photo/young-mother-taking-care-her-little-baby-girl-beautiful-mom-her-daughter-indoors-bedroom-loving-family-attractive-mum-holding-her-child_136813-261.jpg',
    'https://images.ctfassets.net/9l3tjzgyn9gr/3HQ9DOnGNgAPXtH8W1xpuS/08e4de3bec3ef8fbcc46272e011a1f6e/newborn-baby-mommy-and-son-mom-and-baby-new-mother_t20_eoz0WW.jpg?w=1800&q=50&fm=jpg&fl=progressive',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeAccount()));
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage: AssetImage(motherImage),
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
      drawer: getDrawer(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //createListTileHome(context, LIGHT_PINK_COLOR, pregnancy, "Tuần thứ 3 của thai kì", "Bạn còn 259 ngày để gặp được bé", ChildPrenancy()),
                    //createListTileHome(context, LIGHT_BLUE_COLOR, embe, "Bé đã 6 tháng 3 ngày tuổi", "Bạn có thể bắt đầu cho bé ăn dậm", ChildPrenancy()),
                    createListTileHome(context, LIGHT_GREY_COLOR, empty, "Chưa có thông tin", "Nhấp vào để thêm thông tin bé/thai kì ", ChildrenInfo()),
                    SizedBox(height: 20,),
                    createTitle("Tính năng nổi bật"),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        createButtonTextImage("Tiêm chủng", injection),
                        createButtonTextImage("Lịch khám bệnh", illSchedule),
                        createButtonTextImage("Mốc phát triển", developmentMilestone),
                      ],
                    ),
                    SizedBox(height: 10,),
                    createTitle("Tin tức mới nhất"),
                  ],
                ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                children:
                _listNews.map((item) =>
                    createNewsItem(item, "Promum Diamond - vitamin tổng hợp cho bà bầu", readIcon, "10 phút đọc")
                    ).toList(),
            ),)
          ],
        ),
      ),
    );
  }
  
  Widget createNewsItem(String _imageURL, String _title, String _icon, String _estimatedTime){
    return Card(
      elevation: 2,
      child: Container(
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(_imageURL)
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                child: Text(_title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Image(
                    image: AssetImage(_icon),
                    height: 30,
                    width: 30,
                  ),
                  Text(_estimatedTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



