import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Model/article_model.dart';
import 'package:mumbi_app/Model/category_model.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mumbi_app/helper/news.dart';
import 'article_view.dart';
import 'drawer_view.dart';

class GuideBook extends StatefulWidget {
  const GuideBook({Key key}) : super(key: key);

  @override
  _GuideBookState createState() => _GuideBookState();
}

class _GuideBookState extends State<GuideBook> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  List<ArticleModel> articlesCard = <ArticleModel>[];

  bool _loading = true;

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(icon: Icon(Icons.search),
                onPressed: () => {}
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(icon: Image.asset(bookmark),
                  onPressed: () => {}
              ),
            ),
          ),
        ],
      ),
      drawer: getDrawer(context),
      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,),
          child:Column(
            children: <Widget>[

              ///Blogs
              Container(
                padding: EdgeInsets.only(top:16),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 7,
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        dateTime: articles[index].publishedAt,
                        url: articles[index].url,
                      );
                    }),
              ),

              //Kien thuc chung
              Column(
                children: [
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Kiến thức chung",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Palette.kToDark),),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 13,),
                    height: 200,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return CategortTitle(
                            imageUrl: categories[index].imgeUrl,
                            categoryName: categories[index].cateforyName,
                            dateTime: categories[index].dateTime,
                          );
                        }),
                  ),
                ],
              ),

              //Moc phat trien
              Column(
                children: [
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Mốc phát triển",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Palette.kToDark),),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 13,),
                    height: 200,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return CategortTitle(
                            imageUrl: categories[index].imgeUrl,
                            categoryName: categories[index].cateforyName,
                            dateTime: categories[index].dateTime,
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, dateTime;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc, @required this.url, @required this.dateTime});
  // final items= List.from(Da)

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            )));
      },
      child: Container(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, height: 80, width: 80,fit: BoxFit.cover,),
              ),
              Container(
                padding: EdgeInsets.only(left: 90,),
                child: Stack(
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 2,),
                          ),
                          Row(
                            children: [
                              Text(
                                dateTime, style: TextStyle(fontSize: 13,color: Colors.black54),),
                              IconButton(
                                // padding: EdgeInsets.only(right: 80, top: 50),
                                icon: Image.asset(bookmark),
                                onPressed: () =>{
                                  buildInsertButton(),
                                },
                              ),
                            ],
                          ),],
                      )
                    ]
                ),
              )
            ],
          )
      ),
    );
  }
}

Widget buildInsertButton() => ElevatedButton(
    onPressed: () =>{}
);

class CategortTitle extends StatelessWidget {
  final imageUrl, categoryName, dateTime;
  CategortTitle({this.imageUrl,this.categoryName, this.dateTime});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft:Radius.circular(10.0) ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 252, height: 96, fit: BoxFit.cover,)),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 252,height: 90,
              child: Column(
                children: <Widget>[
                  Text(categoryName, style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),),
                  // Text(dateTime),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xffE25D7D, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffE25D7D ),//10%
      100: const Color(0xffb74c3a),//20%
      200: const Color(0xffa04332),//30%
      300: const Color(0xff89392b),//40%
      400: const Color(0xff733024),//50%
      500: const Color(0xff5c261d),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );
}