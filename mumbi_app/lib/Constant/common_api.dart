//final String HOST_ADDRESS = "https://192.168.97.6:45455";
final String HOST_ADDRESS = "http://mumbicapstone-dev.ap-southeast-1.elasticbeanstalk.com";

final String LOGIN = getApiPath("/api/Accounts/Authenticate");

final String GET_MOM_BY_ID = getApiPath("/api/Moms/GetMomBy/");
final String UPDATE_MOM = getApiPath("/api/Moms/UpdateMom/");

final String GET_DAD_BY_MOM = getApiPath("/api/Dads/GetDadBy/");
final String ADD_DAD = getApiPath("/api/Dads/AddDad");
final String UPDATE_DAD = getApiPath("/api/Dads/UpdateDad/");
final String DELETE_DAD = getApiPath("/api/Dads/DeleteDad/");

final String ADD_CHILD = getApiPath("/api/Childrens/AddChildren");
final String GET_CHILD_BY_ID = getApiPath("/api/Childrens/GetChildrenBy/");
final String GET_CHILD_BY_MOM = getApiPath("/api/Childrens/GetChildrenByMom/");
final String UPDATE_CHILD_INFO = getApiPath("/api/Childrens/updateChildrenInformation/");
final String DELETE_CHILD = getApiPath("/api/Childrens/DeleteChildren/");


String getApiPath(String path){
  return HOST_ADDRESS + path;
}