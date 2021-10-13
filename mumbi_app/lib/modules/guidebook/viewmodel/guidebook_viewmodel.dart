import 'dart:convert';

import 'package:mumbi_app/modules/guidebook/models/guidebook_model.dart';
import 'package:mumbi_app/modules/guidebook/repositories/guidebook_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class GuidebookViewModel extends Model {
  static GuidebookViewModel _instance;

  static GuidebookViewModel getInstance() {
    if (_instance == null) {
      _instance = GuidebookViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  num pageSize = 10;
  num currentPage;
  num totalPage;
  bool isLoading = true;
  List<GuidebookModel> guidebookListModel;

  void getGuidebook(bool highlightsFlag, num typeId) async {
    try {
      isLoading = true;
      String data = await GuidebookRepository.apiGetGuidebook(1, highlightsFlag, typeId);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> guidebookList = jsonList['data'];
      if (guidebookList != null) {
        guidebookListModel =
            guidebookList.map((e) => GuidebookModel.fromJson(e)).toList();
      } else {
        guidebookListModel = null;
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMoreGuidebook(bool highlightsFlag, num typeId) async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        String data = await GuidebookRepository.apiGetGuidebook(
            ++currentPage, highlightsFlag, typeId);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> guidebookList = jsonList['data'];
        if (guidebookList != null) {
          List<GuidebookModel> moreGuidebookListModel =
              guidebookList.map((e) => GuidebookModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          guidebookListModel.addAll(moreGuidebookListModel);
        } else {
          guidebookListModel = null;
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getRelatedGuidebook(num typeId, String guidebookId) async {
    try {
      isLoading = true;
      String data = await GuidebookRepository.apiGetGuidebook(1, false, typeId);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> guidebookList = jsonList['data'];
      if (guidebookList != null) {
        guidebookListModel =
            guidebookList.map((e) => GuidebookModel.fromJson(e)).toList();
        for (int i = guidebookListModel.length - 1; i >= 0; i--) {
          GuidebookModel guidebookModel = guidebookListModel[i];
          if (guidebookModel.guidebookId == guidebookId) {
            guidebookListModel.removeAt(i);
            if (guidebookListModel.length == 0) {
              guidebookListModel = null;
            }
            break;
          }
        }
      } else {
        guidebookListModel = null;
      }
      notifyListeners();
      isLoading = false;
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
