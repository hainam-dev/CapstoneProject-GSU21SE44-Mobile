import 'dart:convert';

import 'package:mumbi_app/Model/guidebook_model.dart';
import 'package:mumbi_app/Model/savedGuidebook_model.dart';
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

  SavedGuidebookModel savedGuidebookModel;
  List<dynamic> savedGuidebookList;
  bool isLoading;
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

  Future<bool> unsavedGuidebook(SavedGuidebookModel savedGuidebookModel) async {
    try {
      String data = await SavedGuidebookRepository.apiUnsavedGuidebook(savedGuidebookModel.id);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void getSavedGuidebookByMom() async{
      String momId = await UserViewModel.getUserID();
      isLoading = true;
      try{
        String data = await SavedGuidebookRepository.apiGetSavedGuidebookByMom(momId);
        Map<String, dynamic> jsonList = json.decode(data);
        savedGuidebookList = jsonList['data'];
        if(savedGuidebookList != null){
          savedGuidebookListModel = savedGuidebookList.map((e) => SavedGuidebookModel.fromJson(e)).toList();
        }
        isLoading = false;
        notifyListeners();
      }catch(e){
        print("error: " + e.toString());
      }
  }

  void checkSavedGuidebook(String guidebookId) async {
    try{
      isLoading = true;
      String userId = await UserViewModel.getUserID();
      var checkSaved = await SavedGuidebookRepository.apiCheckSavedGuidebook(userId, guidebookId);
      List checkSavedJsonList = json.decode(checkSaved)['data'];
      savedGuidebookModel = new SavedGuidebookModel();
      if(checkSavedJsonList != null){
        List savedModelList = checkSavedJsonList.map((e) => SavedGuidebookModel.fromJson(e)).toList();
        savedGuidebookModel.id = savedModelList[0].id;
      }else{
        savedGuidebookModel.id = 0;
      }
      isLoading = false;
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }
}