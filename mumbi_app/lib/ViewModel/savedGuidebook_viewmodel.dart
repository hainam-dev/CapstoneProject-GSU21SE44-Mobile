import 'dart:convert';

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

  num pageSize = 10;
  num currentPage;
  num totalPage;
  SavedGuidebookModel savedGuidebookModel;
  bool isLoading = true;
  List<SavedGuidebookModel> savedGuidebookListModel;

  void getSavedGuidebook() async{
      try{
        isLoading = true;
        String momId = await UserViewModel.getUserID();
        String data = await SavedGuidebookRepository.apiGetSavedGuidebook(momId,1);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> savedGuidebookList = jsonList['data'];
        if(savedGuidebookList != null){
          savedGuidebookListModel = savedGuidebookList.map((e) => SavedGuidebookModel.fromJson(e)).toList();
        }
        currentPage = jsonList['pageNumber'];
        totalPage = jsonList['total'] / pageSize;
        isLoading = false;
        notifyListeners();
      }catch(e){
        print("error: " + e.toString());
      }
  }

  void getMoreSavedGuidebook() async{
    try{
      if(currentPage < totalPage){
        isLoading = true;
        String momId = await UserViewModel.getUserID();
        String data = await SavedGuidebookRepository.apiGetSavedGuidebook(momId, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> savedGuidebookList = jsonList['data'];
        if(savedGuidebookList != null){
          List<SavedGuidebookModel> moreSavedGuidebookListModel = savedGuidebookList.map((e) => SavedGuidebookModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          savedGuidebookListModel.addAll(moreSavedGuidebookListModel);
        }
        isLoading = false;
        notifyListeners();
      }
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

  Future<bool> saveGuidebook(String newsId) async {
    SavedGuidebookModel savedGuidebookModel = SavedGuidebookModel();

    String momId = await UserViewModel.getUserID();
    savedGuidebookModel.momId = momId;
    savedGuidebookModel.guidebookId = newsId;
    try {
      String result = await SavedGuidebookRepository.apiSaveGuidebook(savedGuidebookModel);
      if(result != null){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> unsavedGuidebook(SavedGuidebookModel savedGuidebookModel) async {
    try {
      String result = await SavedGuidebookRepository.apiUnsavedGuidebook(savedGuidebookModel.id);
      if(result != null){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}