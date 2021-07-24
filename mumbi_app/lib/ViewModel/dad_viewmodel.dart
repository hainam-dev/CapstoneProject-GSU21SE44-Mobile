import 'dart:convert';

import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Repository/dad_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DadViewModel extends Model{

  static DadViewModel _instance;

  static DadViewModel getInstance() {
    if (_instance == null) {
      _instance = DadViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  DadModel dadModel;

  void getDadByMom() async{
    if(_instance != null){
      String momID = await UserViewModel.getUserID();
      try{
        var data = await DadRepository.apiGetDadByMomID(momID);
        if(data != null){
          data = jsonDecode(data);
          dadModel = DadModel.fromJson(data);
          notifyListeners();
        }
      }catch (e){
        print("error: " + e.toString());
      }
    }
  }

  Future<bool> addDad(DadModel dadModel) async {
    String momId = await UserViewModel.getUserID();
    dadModel.momID = momId;
    try {
      String data = await DadRepository.apiAddDad(dadModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateDad(DadModel dadModel) async {
    try {
      String data = await DadRepository.apiUpdateDad(dadModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteDad(String dadID) async {
    try {
      String data = await DadRepository.apiDeleteDad(dadID);
      destroyInstance();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}