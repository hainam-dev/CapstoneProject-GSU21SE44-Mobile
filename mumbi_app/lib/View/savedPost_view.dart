import 'package:flutter/material.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedPost extends StatefulWidget {
  @override
  _SavedPostState createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài viết đã lưu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ScopedModel(
          model: SavedNewsViewModel.getInstance(),
          child: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, SavedNewsViewModel model) {
              model.getSavedNewsByMom();
              return model.savedNewsListModel == null
                  ? loadingProgress()
                  : ListView.builder(
                  itemCount: model.savedNewsListModel.length,
                  itemBuilder: (BuildContext context, index) {
                SavedNewsModel guidebookModel = model.savedNewsListModel[index];
                return Container();
              },);
            },
          )),
    );
  }
}
