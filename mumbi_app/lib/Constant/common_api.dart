//final String HOST_ADDRESS = "https://192.168.97.6:45455";
final String HOST_ADDRESS = "http://mumbicapstone-dev.ap-southeast-1.elasticbeanstalk.com";

final String LOGIN = getApiPath("/api/Authentication/Authenticate");

final String GET_MOM_BY_ID = getApiPath("/api/MomInfo/GetMomInfoBy/");
final String UPDATE_MOM = getApiPath("/api/MomInfo/UpdateMomInfo/");

final String GET_DAD_BY_MOM = getApiPath("/api/DadInfo/GetDadInfoBy/");
final String ADD_DAD = getApiPath("/api/DadInfo/AddDadInfo");
final String UPDATE_DAD = getApiPath("/api/DadInfo/UpdateDadInfo/");
final String DELETE_DAD = getApiPath("/api/DadInfo/DeleteDadInfo/");

final String ADD_CHILD = getApiPath("/api/Childrens/AddChildren");
final String GET_CHILD_BY_ID = getApiPath("/api/Childrens/GetChildrenBy/");
final String GET_CHILD_BY_MOM = getApiPath("/api/Childrens/GetChildrenByMom/");
final String UPDATE_CHILD_INFO = getApiPath("/api/Childrens/updateChildrenInformation/");
final String DELETE_CHILD = getApiPath("/api/Childrens/DeleteChildren/");


final String GET_TOOTH_BY_ID = getApiPath("/api/ToothInfo/GetToothInfoBy/");
final String UPDATE_TOOTH_BY_ID = getApiPath("/api/ToothInfo/GetToothByChildId/");


String getApiPath(String path){
  return HOST_ADDRESS + path;
}