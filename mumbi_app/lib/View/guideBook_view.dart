// import 'dart:js';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/article_model.dart';
import 'package:mumbi_app/Model/category_model.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mumbi_app/helper/news.dart';
import 'package:mumbi_app/main.dart';
import 'article_view.dart';
import 'drawer_view.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';
import 'package:mumbi_app/state/state_manager.dart';
import 'package:mumbi_app/View/guideBook_save.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuideBook extends StatefulWidget {
  const GuideBook({Key key}) : super(key: key);

  @override
  _GuideBookState createState() => _GuideBookState();
}

class _GuideBookState extends State<GuideBook> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  List<ArticleModel> articlesCard = <ArticleModel>[];

  // bool _loading = true;
  //
  // getNews() async {
  //   News newsClass = News();
  //   await newsClass.getNews();
  //   articles = newsClass.news;
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          // CircleAvatar(
          //   backgroundColor: Colors.white,
          //   child: IconButton(icon: Icon(Icons.search), onPressed: () => {}),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  icon: SvgPicture.asset(bookmark),
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuidebookSave()),
                        )
                      }),
            ),
          ),
        ],
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              ///Blogs
              BlogTile(),

              //Kien thuc chung
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Kiến thức chung",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: PINK_COLOR),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 13,
                    ),
                    height: 200,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
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
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mốc phát triển",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: PINK_COLOR),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 13,
                    ),
                    height: 200,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
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

class BlogTile extends StatefulWidget {
  const BlogTile({Key key}) : super(key: key);

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  List<ArticleModel> articles = <ArticleModel>[];
  // List<ArticleModel> articlesCard = <ArticleModel>[];
  // String imageUrl, title, desc, url, dateTime, id;
  bool _loading = true;
  var storage = FlutterSecureStorage();
  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  // var storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    // var bookmarkBloc = Provider.of<ArticleList>(context);
    return _loading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: 16),
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleView(
                                    blogUrl: articles[index].guidebookContent,
                                  )));
                    },
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            articles[index].imageURL,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeVertical * 70,
                          padding: EdgeInsets.only(
                            left: 90,
                          ),
                          child: Stack(children: [
                            Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      articles[index].title,
                                      style: BOLD_16,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Stack(children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              articles[index].createdTime,
                                              style: REG_13,
                                            ),
                                            IconButton(
                                              icon: articles[index].status ==
                                                      false
                                                  ? SvgPicture.asset(bookmark)
                                                  : SvgPicture.asset(
                                                      bookmark_choose),
                                              onPressed: () async {
                                                ArticleModel articleModel =
                                                    new ArticleModel(
                                                  id: articles[index].id,
                                                  title: articles[index].title,
                                                  guidebookContent:
                                                      articles[index]
                                                          .guidebookContent,
                                                  createdBy:
                                                      articles[index].createdBy,
                                                  createdTime: articles[index]
                                                      .createdTime,
                                                  imageURL:
                                                      articles[index].imageURL,
                                                );

                                                var saveInstance = context
                                                    .read(saveListProvider)
                                                    .state;
                                                print(saveInstance.toString());

                                                if (isExistInSave(
                                                    saveInstance.state,
                                                    articleModel)) {
                                                  context
                                                      .read(saveListProvider)
                                                      .state
                                                      .remove(articleModel);
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Đã bỏ lưu",
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    duration:
                                                        Duration(seconds: 1),
                                                  ));
                                                  print('cancel');
                                                  articles[index].status =
                                                      false;
                                                } else {
                                                  context
                                                      .read(saveListProvider)
                                                      .state
                                                      .add(articleModel);
                                                  print('SAVE');
                                                  // print(articleModel.toJson() as List<dynamic>);
                                                  articles[index].status = true;
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text("Đã lưu",
                                                        textAlign:
                                                            TextAlign.right),
                                                    duration:
                                                        Duration(seconds: 1),
                                                  ));
                                                }
                                                var string = json.encode(context
                                                    .read(saveListProvider)
                                                    .state
                                                    .state);
                                                // var stringMap  = string.map((model) => ArticleModel.fromJson(model)).toList;
                                                await storage.write(
                                                    key: saveKey,
                                                    value: string);
                                                print('DA ENCODE');
                                                print(storage
                                                    .read(key: saveKey)
                                                    .toString());
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
                                ])
                          ]),
                        )
                      ],
                    )),
                  );
                }),
          );
  }

  bool isExistInSave(List<ArticleModel> state, ArticleModel articleModel) {
    bool found = false;
    state.forEach((element) {
      if (element.id == articleModel.id) found = true;
    });
    return found;
  }
}

class CategortTitle extends StatelessWidget {
  final imageUrl, categoryName, dateTime;
  CategortTitle({this.imageUrl, this.categoryName, this.dateTime});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 252,
                  height: 96,
                  fit: BoxFit.cover,
                )),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 252,
              height: 90,
              child: Column(
                children: <Widget>[
                  Text(
                    categoryName,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
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
