// import 'dart:convert';
// import 'dart:js_util';

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/article_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/article_view.dart';
import 'package:mumbi_app/View/guideBook_view.dart';
import 'package:mumbi_app/state/state_manager.dart';

class GuidebookSave extends StatefulWidget {
  const GuidebookSave({Key key, this.articleModel}) : super(key: key);
  final ArticleModel articleModel;

  @override
  _GuidebookSaveState createState() => _GuidebookSaveState();
}

class _GuidebookSaveState extends State<GuidebookSave> {
  var storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      // await storage.deleteAll();
      String savePost = await storage.read(key: saveKey);
      print('savePost: '+ savePost);
      if(savePost != null && savePost.isNotEmpty){
        final listcart = json.decode(savePost) as List;
        // final listCartParsed = context.read(saveListProvider);
        //todo
        final listCartParsed = listcart.map((model) => ArticleModel.fromJson(model)).toList();
        if(listCartParsed != null && listCartParsed.length >0)
          context.read(saveListProvider).state.state = listCartParsed;
      } else{
        context.read(saveListProvider).state == null;
      }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var bookmarkBloc = Provider.of<ArticleList>(context);
    var items = context.read(saveListProvider).state.state;
    return Scaffold(
        appBar: AppBar(
          title: Text('Bài viết đã lưu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:
        Container(
          padding: EdgeInsets.only(top: 16),
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        // bookmarkBloc.list[index].urlToImage,
                        items[index].imageURL,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeVertical * 70,
                      padding: EdgeInsets.only(left: 90,),
                      child: Stack(children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  // bookmarkBloc.list[index].title,
                                  items[index].title,
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
                                          // bookmarkBloc.list[index].publishedAt,
                                          items[index].createdTime,
                                          style: REG_13,
                                        ),
                                        IconButton(
                                          icon: items[index].status == false ? SvgPicture.asset(bookmark) : SvgPicture.asset(bookmark_choose),
                                          onPressed: () async{
                                            ArticleModel articleModel = new ArticleModel(
                                              // id: bookmarkBloc.list[index].id,
                                              // title: bookmarkBloc.list[index].title,
                                              // content: bookmarkBloc.list[index].url,
                                              // author: bookmarkBloc.list[index].author,
                                              // publishedAt: bookmarkBloc.list[index].publishedAt,
                                              // urlToImage: bookmarkBloc.list[index].urlToImage,

                                              id: items[index].id,
                                              title: items[index].title,
                                              guidebookContent: items[index].guidebookContent,
                                              createdBy: items[index].createdBy,
                                              createdTime: items[index].createdTime,
                                              imageURL: items[index].imageURL,
                                            );
                                            var saveInstance = context.read(saveListProvider).state;

                                            if(isExistInSave(saveInstance.state,articleModel)){
                                              // bookmarkBloc.list.remove(articleModel);
                                              context.read(saveListProvider).state.remove(articleModel);
                                              print('đã bỏ');
                                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Đã bỏ lưu", textAlign: TextAlign.right,), duration: Duration(seconds: 1),));
                                              items[index].status = false;
                                            } else{
                                              // bookmarkBloc.list.add(articleModel);
                                              context.read(saveListProvider).state.add(articleModel);
                                              print("save: List trước encode nè:"+   items.toString());
                                              print('đã thêm');
                                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Đã lưu", textAlign: TextAlign.right,), duration: Duration(seconds: 1),));
                                            }
                                            var string =  json.encode(context.read(saveListProvider).state.state);
                                            print("save: List đã thêm" + string);
                                            await storage.write(key: saveKey, value: string);
                                            setState(() {

                                            });
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
                );
              }),
        )

    );
  }
  bool isExistInSave(List<ArticleModel> state, ArticleModel articleModel) {
    bool found = false;
    state.forEach((element) {
      if(element.id == articleModel.id)
        found = true;
    });
    return found;
  }
}

// class ArticleList extends ChangeNotifierProvider{
//   // ArticleList(List<ArticleModel> state):super();
//   bool isSave = false;
//   List<ArticleModel> list =[];
//
//   void add(ArticleModel articleModel){
//     // state = [
//     //   ...state,
//     //   articleModel
//     // ];
//
//     list.add(articleModel);
//     isSave =  true;
//     print( 'add thành công');
//     // notifyListeners();
//   }
//
// void remove(ArticleModel removeItem){
//   list.remove(removeItem);
//   print("đã bỏ");
//   // notifyListeners();
// }
// }

class ArticleList extends StateNotifier<List<ArticleModel>>{
  ArticleList(List<ArticleModel> state):super(state ?? []);
  // bool isSave = false;
  // List<ArticleModel> list =[];

  void add(ArticleModel articleModel){
    state = [
      ...state,
      articleModel
    ];

    // list.add(articleModel);
    // isSave =  true;
    // print( 'add thành công');
    // notifyListeners();
  }

  void remove(ArticleModel removeItem){
    state = state.where((saveModel) => saveModel.id != removeItem.id).toList();

    // list.remove(removeItem);
    // print("đã bỏ");
    // notifyListeners();
  }
}

