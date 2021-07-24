import 'dart:convert';

import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Repository/mom_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MomViewModel extends Model{

  static MomViewModel _instance;

  static MomViewModel getInstance() {
    if (_instance == null) {
      _instance = MomViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  MomModel momModel;

  void getMomByID() async{
    if(_instance != null){
      String id = await UserViewModel.getUserID();
      try{
        var data = await MomRepository.apiGetMomByID(id);
        if(data != null){
          data = jsonDecode(data);
          momModel = MomModel.fromJson(data);
          notifyListeners();
        }
      }catch (e){
        print("error: " + e.toString());
      }
    }
  }

  Future<bool> updateMom(MomModel momModel) async {
    try {
      String data = await MomRepository.apiUpdateMom(momModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}