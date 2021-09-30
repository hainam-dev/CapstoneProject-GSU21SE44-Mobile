import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/guidebookType_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/drawer_view.dart';
import 'package:mumbi_app/View/savedPost_view.dart';
import 'package:mumbi_app/ViewModel/guidebookType_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

import 'guideBook_view.dart';

class GuidebookCategory extends StatefulWidget {
  @override
  _GuidebookCategoryState createState() => _GuidebookCategoryState();
}

class _GuidebookCategoryState extends State<GuidebookCategory> {

  GuidebookTypeViewModel guidebookTypeViewModel;

  @override
  void initState() {
    super.initState();
    guidebookTypeViewModel = GuidebookTypeViewModel.getInstance();
    guidebookTypeViewModel.getAllType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cẩm nang'),
        actions: [
          GotoSavePostButton(context),
        ],
      ),
      drawer: getDrawer(context),
      body: ScopedModel(
          model: guidebookTypeViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, GuidebookTypeViewModel model) {
              return model.guidebookTypeListModel == null
                  ? loadingProgress()
                  : ListView.builder(
                itemCount: model.guidebookTypeListModel.length,
                itemBuilder: (BuildContext context, index) {
                  GuidebookTypeModel guidebookTypeModel =
                  model.guidebookTypeListModel[index];
                    return TypeItem(context, guidebookTypeModel);
                },
              );
            },
          )),
    );
  }

  Widget TypeItem(BuildContext context,GuidebookTypeModel guidebookTypeModel){
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GuideBook(guidebookTypeModel)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text(guidebookTypeModel.type,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text(checkQuantity(guidebookTypeModel.postQuantity).toString() + " bài",style: TextStyle(fontSize: 18,color: LIGHT_DARK_GREY_COLOR),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GotoSavePostButton(context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
            icon: Image(
              image: AssetImage(saved),
              height: SizeConfig.blockSizeVertical * 8,
              width: SizeConfig.blockSizeHorizontal * 8,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedPost(0)),
              )
            }),
      ),
    );
  }

  num checkQuantity(num quantity){
    if(quantity != null){
      return quantity;
    }else{
      return 0;
    }
  }
}
