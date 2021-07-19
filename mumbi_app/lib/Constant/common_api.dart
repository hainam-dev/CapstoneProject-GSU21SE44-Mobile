//final String HOST_ADDRESS = "https://192.168.97.6:45455";
final String HOST_ADDRESS = "https://service.mumbi.xyz"; //"http://mumbicapstone-dev.ap-southeast-1.elasticbeanstalk.com";

final String LOGIN = getApiPath("/api/Authentication/Authenticate");

final String GET_MOM_BY_ID = getApiPath("/api/MomInfo/GetMomInfoBy/");
final String UPDATE_MOM = getApiPath("/api/MomInfo/UpdateMomInfo/");

final String GET_DAD_BY_MOM = getApiPath("/api/DadInfo/GetDadInfoBy/");
final String ADD_DAD = getApiPath("/api/DadInfo/AddDadInfo");
final String UPDATE_DAD = getApiPath("/api/DadInfo/UpdateDadInfo/");
final String DELETE_DAD = getApiPath("/api/DadInfo/DeleteDadInfo/");

final String ADD_CHILD = getApiPath("/api/ChildInfo/AddChildInfo");
final String GET_CHILD_BY_ID = getApiPath("/api/ChildInfo/GetChildInfoById/");
final String GET_CHILD_BY_MOM = getApiPath("/api/ChildInfo/GetChildInfoByMomId/");
final String UPDATE_CHILD_INFO = getApiPath("/api/ChildInfo/UpdateChildInfo/");
final String DELETE_CHILD = getApiPath("/api/ChildInfo/DeleteChildInfo/");

final String GET_NEWS_BY_ID = getApiPath("/api/News/GetNewsBy/");
final String GET_ALL_NEWS = getApiPath("/api/News/GetAllNews");
final String GET_SAVED_NEWS_BY_MOM_ID = getApiPath("/api/NewsMom/GetNewsMomBy/");

final String GET_ALL_GUIDEBOOK = getApiPath("/api/Guidebooks/GetAllGuidebook");
final String GET_SAVED_GUIDEBOOK_BY_MOM_ID = getApiPath("/api/GuidebookMom/GetGuidebookMomBy/");

final String ADD_DIARY = getApiPath("/api/Diaries/AddDiary");
final String GET_ALL_DIARY_OF_CHILD = getApiPath("/api/Diaries/GetDiaryOfChildren/");
final String GET_ALL_PUBLIC_DIARY = getApiPath("/api/Diaries/GetDiaryPublic");
final String DELETE_DIARY = getApiPath("/api/Diaries/DeleteDiary/");

final String GET_TOOTHINFO_BY_ID = getApiPath("/api/ToothInfo/GetToothInfoBy/");
final String GET_TOOTH_BY_CHILD_ID = getApiPath("/api/Tooth/GetToothByChildId/");
final String UPSERT_TOOTH_BY_TOOTH_ID = getApiPath("/api/Tooth/UpsertTooth/");

//post vaccination info
final String POST_PERSONAL_INFO_AddInjectedPerson = getApiPath("/api/InjectedPerson/AddInjectedPerson");
final String POST_HISTORY_VACCIN_AddInjectionSchedule = getApiPath("/api/InjectionSchedule/AddInjectionSchedule");


String getApiPath(String path){
  return HOST_ADDRESS + path;
}