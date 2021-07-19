import 'dart:convert';

import 'package:mumbi_app/Model/savedGuidebook_model.dart';
import 'package:mumbi_app/Repository/guidebook_repository.dart';
import 'package:mumbi_app/Repository/savedGuidebook_Repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedGuidebookViewModel extends Model{

  static SavedGuidebookViewModel _instance;

  static SavedGuidebookViewModel getInstance() {
    if (_instance == null) {
      _instance = SavedGuidebookViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }
  List<dynamic> savedGuidebookList;
  List<SavedGuidebookModel> savedGuidebookListModel;

  Future<bool> saveGuidebook(String newsId) async {
    SavedGuidebookModel savedGuidebookModel = SavedGuidebookModel();

    String momId = await UserViewModel.getUserID();
    savedGuidebookModel.momId = momId;
    savedGuidebookModel.guidebookId = newsId;
    try {
      String data = await SavedGuidebookRepository.apiSaveGuidebook(savedGuidebookModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> unsavedGuidebook(num id) async {
    try {
      String data = await SavedGuidebookRepository.apiUnsavedGuidebook(id);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void getSavedGuidebookByMom() async{
    String momId = await UserViewModel.getUserID();
    try{
      String data = await SavedGuidebookRepository.apiGetSavedGuidebookByMom(momId);
      Map<String, dynamic> jsonList = json.decode(data);
      savedGuidebookList = jsonList['data'];
      savedGuidebookListModel = savedGuidebookList.map((e) => SavedGuidebookModel.fromJson(e)).toList();
      savedGuidebookListModel.sort((a,b) => b.id.compareTo(a.id));
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }
}