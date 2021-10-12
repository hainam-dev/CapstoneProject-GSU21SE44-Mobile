import 'dart:convert';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:mumbi_app/modules/family/models/dad_model.dart';
import 'package:mumbi_app/modules/family/repositories/dad_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class DadViewModel extends Model {
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

  void getDadByMom() async {
    String momID = await UserViewModel.getUserID();
    try {
      var data = await DadRepository.apiGetDadByMomID(momID);
      if (data != null) {
        data = jsonDecode(data);
        dadModel = DadModel.fromJson(data);
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> addDad(DadModel dadModel) async {
    String momId = await UserViewModel.getUserID();
    dadModel.momID = momId;
    try {
      String result = await DadRepository.apiAddDad(dadModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateDad(DadModel dadModel) async {
    try {
      String result = await DadRepository.apiUpdateDad(dadModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteDad(String dadID) async {
    try {
      String result = await DadRepository.apiDeleteDad(dadID);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}
