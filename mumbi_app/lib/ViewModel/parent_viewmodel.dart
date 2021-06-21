import 'dart:convert';

import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Repository/dad_repository.dart';
import 'package:mumbi_app/Repository/mom_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class ParentViewModel extends Model{

  MomModel momModel;

  ParentViewModel(){
    getMomByID();
  }

  //MOM
  void getMomByID() async{
    String accountID = "";
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      accountID = user['data']['email'];
    }
    try{
      var data = await MomRepository.apiGetMomByID(accountID);
      if(data != null){
        data = jsonDecode(data);
        momModel = MomModel.fromJson(data);
        notifyListeners();
      }
    }catch (e){
      print("error: " + e.toString());
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

  //DAD
  Future<bool> addDad(DadModel dadModel) async {
    try {
      String data = await DadRepository.apiAddDad(dadModel);
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

  void deleteDad(String accountID) async {
    try {
      String data = await DadRepository.apiDeleteDad(accountID);
    } catch (e) {
      print("error: " + e.toString());
    }
  }

}