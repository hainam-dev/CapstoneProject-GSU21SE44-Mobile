import 'dart:convert';

import 'package:mumbi_app/Model/guidebookType_model.dart';
import 'package:mumbi_app/Repository/guidebook_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookTypeViewModel extends Model{

  static GuidebookTypeViewModel _instance;

  static GuidebookTypeViewModel getInstance() {
    if (_instance == null) {
      _instance = GuidebookTypeViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> guidebookTypeList;
  List<GuidebookTypeModel> guidebookTypeListModel;

  void getAllType() async {
    try{
      String data = await GuidebookRepository.apiGetAllTypeOfGuidebook();
      Map<String, dynamic> jsonList = json.decode(data);
      guidebookTypeList = jsonList['data'];
      guidebookTypeListModel = guidebookTypeList.map((e) => GuidebookTypeModel.fromJson(e)).toList();
      await Future.forEach(guidebookTypeListModel, (guidebookTypeModel) async {
        await countPostQuantity(guidebookTypeModel);
      });
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }

  void countPostQuantity(GuidebookTypeModel guidebookTypeModel) async {
    var countQuantity = await GuidebookRepository.apiCountQuantity(guidebookTypeModel.id);
    guidebookTypeModel.postQuantity = json.decode(countQuantity)['total'];
  }
}