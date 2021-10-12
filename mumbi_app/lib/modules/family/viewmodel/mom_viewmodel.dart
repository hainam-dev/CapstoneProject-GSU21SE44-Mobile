import 'dart:convert';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:mumbi_app/modules/family/models/mom_model.dart';
import 'package:mumbi_app/modules/family/repositories/mom_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class MomViewModel extends Model {
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

  void getMomByID() async {
    try {
      String id = await UserViewModel.getUserID();
      var data = await MomRepository.apiGetMomByID(id);
      if (data != null) {
        data = jsonDecode(data);
        momModel = MomModel.fromJson(data);
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> updateMom(MomModel momModel) async {
    try {
      String result = await MomRepository.apiUpdateMom(momModel);
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
