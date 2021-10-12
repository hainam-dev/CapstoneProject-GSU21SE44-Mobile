import 'dart:convert';
import 'package:mumbi_app/modules/guidebook/models/guidebook_type_model.dart';
import 'package:mumbi_app/modules/guidebook/repositories/guidebook_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookTypeViewModel extends Model {
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
    if (_instance != null) {
      try {
        String data = await GuidebookRepository.apiGetAllTypeOfGuidebook();
        Map<String, dynamic> jsonList = json.decode(data);
        guidebookTypeList = jsonList['data'];
        guidebookTypeListModel = guidebookTypeList
            .map((e) => GuidebookTypeModel.fromJson(e))
            .toList();
        notifyListeners();
      } catch (e) {
        print("error: " + e.toString());
      }
    }
  }
}
