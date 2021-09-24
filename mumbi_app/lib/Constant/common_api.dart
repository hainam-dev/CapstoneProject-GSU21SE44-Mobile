final String HOST_ADDRESS = "https://mumbi.xyz";

final String LOGIN = getApiPath("/api/Authentication/Authenticate");

final String GET_MOM_BY_ID = getApiPath("/api/MomInfo/GetMomInfoBy/");
final String UPDATE_MOM = getApiPath("/api/MomInfo/UpdateMomInfo/");

final String GET_DAD_BY_MOM = getApiPath("/api/DadInfo/GetDadInfoBy/");
final String ADD_DAD = getApiPath("/api/DadInfo/AddDadInfo");
final String UPDATE_DAD = getApiPath("/api/DadInfo/UpdateDadInfo/");
final String DELETE_DAD = getApiPath("/api/DadInfo/DeleteDadInfo/");

final String ADD_CHILD = getApiPath("/api/ChildInfo/AddChildInfo");
final String GET_CHILD = getApiPath("/api/ChildInfo/GetChildInfo");
final String UPDATE_CHILD_INFO = getApiPath("/api/ChildInfo/UpdateChildInfo/");
final String DELETE_CHILD = getApiPath("/api/ChildInfo/DeleteChildInfo/");

final String GET_CHILD_HISTORY = getApiPath("/api/ChildHistory/GetChildHistoryByChildId/");
final String UPDATE_CHILD_HISTORY = getApiPath("/api/ChildHistory/UpdateChildHistory");
final String GET_PREGNANCY_HISTORY = getApiPath("/api/PregnancyHistory/GetPregnancyHistoryByChildId/");
final String UPDATE_PREGNANCY_HISTORY = getApiPath("​/api​/PregnancyHistory​/UpdatePregnancyHistory/");

final String GET_NEWS = getApiPath("/api/News/GetNews");
final String SAVE_NEWS = getApiPath("/api/NewsMom/AddNewsMom");
final String UNSAVED_NEWS = getApiPath("/api/NewsMom/DeleteNewsMom/");
final String GET_SAVED_NEWS_BY_MOM_ID =
    getApiPath("/api/NewsMom/GetNewsMomBy/");

final String GET_GUIDEBOOK = getApiPath("/api/Guidebooks/GetGuidebook");
final String SAVE_GUIDEBOOK = getApiPath("/api/GuidebookMom/AddGuidebookMom");
final String UNSAVED_GUIDEBOOK =
    getApiPath("/api/GuidebookMom/DeleteGuidebookMom/");
final String GET_SAVED_GUIDEBOOK_BY_MOM_ID =
    getApiPath("/api/GuidebookMom/GetGuidebookMomBy/");

final String ADD_DIARY = getApiPath("/api/Diaries/AddDiary");
final String UPDATE_DIARY = getApiPath("/api/Diaries/UpdateDiary/");
final String GET_ALL_DIARY_OF_CHILD = getApiPath("/api/Diaries/GetDiaryOfChildren/");
final String DELETE_DIARY = getApiPath("/api/Diaries/DeleteDiary/");

final String ADD_COMMUNITY_POST = getApiPath("/api/CommunityPost/AddCommunityPost");
final String GET_COMMUNITY_POST = getApiPath("/api/CommunityPost/GetCommunityPost");
final String GET_USER_COMMUNITY_POST = getApiPath("/api​/CommunityPost​/GetUserCommunityPost");
final String UPDATE_COMMUNITY_POST = getApiPath("/api/CommunityPost/UpdateCommunityPost/");
final String DELETE_COMMUNITY_POST = getApiPath("/api/CommunityPost/DeleteCommunityPost/");

final String ADD_POST_COMMENT = getApiPath("/api/PostComment/AddPostComment");
final String ADD_REPLY_POST_COMMENT = getApiPath("/api​/PostComment​/AddReplyPostComment");
final String GET_COMMENT = getApiPath("/api/PostComment/GetPostComment");
final String UPDATE_COMMENT = getApiPath("/api​/PostComment​/UpdatePostComment​/");
final String DELETE_COMMENT = getApiPath("/api/PostComment/DeletePostComment/");

final String ADD_POST_REACTION = getApiPath("/api/Reaction/AddReactionPost");
final String ADD_COMMENT_REACTION = getApiPath("/api/Reaction/AddReactionComment");
final String GET_REACTION = getApiPath("/api/Reaction/GetReaction");
final String DELETE_REACTION = getApiPath("/api/Reaction/DeleteReaction/");

final String GET_TOOTHINFO_BY_ID = getApiPath("/api/ToothInfo/GetToothInfoBy/");
final String GET_TOOTH_BY_CHILD_ID = getApiPath("/api/Tooth/GetToothByToothId/");
final String GET_ALL_TOOTH_BY_CHILD_ID = getApiPath("/api/Tooth/GetToothByChildId/");
final String UPSERT_TOOTH_BY_TOOTH_ID = getApiPath("/api/Tooth/UpsertTooth/");

final String GET_ACTIVITY = getApiPath("/api/Activity/GetActivity");

final String GET_STAND_INDEX_BY_GENDER = getApiPath("/api/StandardIndex/GetStandardIndexBy/");

final String GET_ACTION_BY_TYPE = getApiPath("/api/Action/GetActionBy/");
final String GET_ACTION_ID_BY_CHILDID = getApiPath("/api/ActionChild/GetActionChildBy/");
final String UPDATE_ACTION_ID_BY_CHILDID = getApiPath("/api/ActionChild/UpsertActionChild/");

final String GET_INJECTION_SCHEDULE = getApiPath("/api/InjectionSchedule/GetInjectionSchedules/");
//post vaccination info
final String POST_PERSONAL_INFO_AddInjectedPerson =
    getApiPath("/api/InjectedPerson/AddInjectedPerson");
final String POST_HISTORY_VACCIN_AddInjectionSchedule =
    getApiPath("/api/InjectionSchedule/AddInjectionSchedule");

String getApiPath(String path) {
  return HOST_ADDRESS + path;
}
