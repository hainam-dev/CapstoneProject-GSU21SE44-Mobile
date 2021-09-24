import 'dart:convert';

import 'package:mumbi_app/Model/activity_model.dart';
import 'package:mumbi_app/Repository/activity_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ActivityViewModel extends Model{
  static ActivityViewModel _instance;

  static ActivityViewModel getInstance() {
    if (_instance == null) {
      _instance = ActivityViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> activityMusicList;
  bool loadingActivityMusicListModel;
  List<ActivityModel> activityMusicListModel;

  List<dynamic> activityStoryList;
  bool loadingActivityStoryListModel;
  List<ActivityModel> activityStoryListModel;

  List<dynamic> activityPoetryList;
  bool loadingActivityPoetryListModel;
  List<ActivityModel> activityPoetryListModel;


  Future<void> getActivityByType(num id) async {
      if(id == 1){
        loadingActivityMusicListModel = true;
        try {
          String data = await ActivityRepository.apiGetActivityByType(id);
          Map<String, dynamic> jsonList = json.decode(data);
          activityMusicList = jsonList['data'];
          if (activityMusicList != null) {
            activityMusicListModel = activityMusicList.map((e) => ActivityModel.fromJson(e)).toList();
          }
          notifyListeners();
          loadingActivityMusicListModel = false;
        } catch (e) {
          print("error: " + e.toString());
        }
      }else if(id == 2){
        loadingActivityPoetryListModel = true;
        try {
          String data = await ActivityRepository.apiGetActivityByType(id);
          Map<String, dynamic> jsonList = json.decode(data);
          activityPoetryList = jsonList['data'];
          if (activityPoetryList != null) {
            activityPoetryListModel = activityPoetryList.map((e) => ActivityModel.fromJson(e)).toList();
          }
          notifyListeners();
          loadingActivityPoetryListModel = false;
        } catch (e) {
          print("error: " + e.toString());
        }
      }else if(id == 3){
        loadingActivityStoryListModel = true;
        try {
          String data = await ActivityRepository.apiGetActivityByType(id);
          Map<String, dynamic> jsonList = json.decode(data);
          activityStoryList = jsonList['data'];
          if (activityStoryList != null) {
            activityStoryListModel = activityStoryList.map((e) => ActivityModel.fromJson(e)).toList();
          }
          notifyListeners();
          loadingActivityStoryListModel = false;
        } catch (e) {
          print("error: " + e.toString());
        }
      }
    }
}