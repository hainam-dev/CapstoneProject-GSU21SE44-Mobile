import 'dart:convert';

import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Repository/guidebook_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookViewModel extends Model{

  static GuidebookViewModel _instance;

  static GuidebookViewModel getInstance() {
    if (_instance == null) {
      _instance = GuidebookViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> guidebookList;
  List<GuidebookModel> guidebookListModel;

  void getAllGuidebook() async{
    try{
      String data = await GuidebookRepository.apiGetGuidebook();
      Map<String, dynamic> jsonList = json.decode(data);
      guidebookList = jsonList['data'];
      guidebookListModel = guidebookList.map((e) => GuidebookModel.fromJson(e)).toList();
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }

}