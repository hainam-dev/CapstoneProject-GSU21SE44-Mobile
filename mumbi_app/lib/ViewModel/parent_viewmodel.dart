import 'dart:convert';

import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Repository/dad_repository.dart';
import 'package:mumbi_app/Repository/mom_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class ParentViewModel extends Model{

  MomModel momModel;
  DadModel dadModel;

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
  void getDadByMom() async{
    String momID = "";
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      momID = user['data']['email'];
    }
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

  Future<bool> addDad(DadModel dadModel) async {
    String momID;
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      momID = user['data']['email'];
    }
    dadModel.momID = momID;
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

  Future<bool> deleteDad(String dadID) async {
    try {
      String data = await DadRepository.apiDeleteDad(dadID);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}