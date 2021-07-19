import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
=======
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/history_vaccination.dart';
>>>>>>> dev-tu/vaccination-feature
import 'package:shared_preferences/shared_preferences.dart';

class VaccinationRespository {
  static final String host = "https://api-stc-v2.vncdc.gov.vn";
  static final String otpCheck = "/otp";
  static final String otpActive = "/activate";
  static final String auth = "/auth";
  static final String memberList = "/thanh_vien?theo_doi=2";
  static final String recover_pass_by_sms = "/recover_pass_by_sms?phoneNumber=";
  static final String create_password = "/create_password";
  static final String historyList = "/lich_su_tiem/vacxin?doi_tuong_id=";
  static String _tokenValue;
  static int _doi_tuong_id;
  static final _KEY_TOKEN = "vaccination_token";
  static final _KEY_DOI_TUONG_ID = "vaccination_doi_tuong_id";

  static Future<int> getDoi_tuong_id() async {
    if (_doi_tuong_id == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _doi_tuong_id = sharedPreferences.getInt(_KEY_DOI_TUONG_ID);
    }
    return _doi_tuong_id;
  }

  static void setDoi_tuong_id(int id) async {
    _doi_tuong_id = id;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_KEY_DOI_TUONG_ID, id);
  }

  static Future<String> getToken() async {
    if (_tokenValue == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _tokenValue = sharedPreferences.getString(_KEY_TOKEN);
    }
    return _tokenValue;
  }

  static void setTokenValue(String token) async {
    _tokenValue = token == null ? "" : token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
<<<<<<< HEAD
    sharedPreferences.setString(_KEY_TOKEN, token);
=======
    sharedPreferences.setString(_KEY_TOKEN, _tokenValue);
  }

  static Future<dynamic> sendPersonalInfo(jsonObject) async {
    var homeAddress = "";
    if (jsonObject["ho_khau_dia_chi"] != null &&
        jsonObject["ho_khau_dia_chi"] != "") {
      homeAddress += jsonObject["ho_khau_dia_chi"] + ", ";
    }

    if (jsonObject["ho_khau_thon_ap"] != null &&
        jsonObject["ho_khau_thon_ap"] != "") {
      homeAddress += jsonObject["ho_khau_thon_ap"] + ", ";
    }

    if (jsonObject["ho_khau_xa"] != null && jsonObject["ho_khau_xa"] != "") {
      homeAddress += jsonObject["ho_khau_xa"] + ", ";
    }

    if (jsonObject["ho_khau_tinh"] != null &&
        jsonObject["ho_khau_tinh"] != "") {
      homeAddress += jsonObject["ho_khau_tinh"] + ", ";
    }

    if (jsonObject["ho_khau_huyen"] != null &&
        jsonObject["ho_khau_huyen"] != "") {
      homeAddress += jsonObject["ho_khau_huyen"];
    }

    var temporaryAddress = "";
    if (jsonObject["tam_tru_dia_chi"] != null &&
        jsonObject["tam_tru_dia_chi"] != "") {
      temporaryAddress += jsonObject["tam_tru_dia_chi"] + ", ";
    }

    if (jsonObject["tam_tru_thon_ap"] != null &&
        jsonObject["tam_tru_thon_ap"] != "") {
      temporaryAddress += jsonObject["tam_tru_thon_ap"] + ", ";
    }

    if (jsonObject["tam_tru_xa"] != null && jsonObject["tam_tru_xa"] != "") {
      temporaryAddress += jsonObject["tam_tru_xa"] + ", ";
    }

    if (jsonObject["tam_tru_huyen"] != null &&
        jsonObject["tam_tru_huyen"] != "") {
      temporaryAddress += jsonObject["tam_tru_huyen"] + ", ";
    }

    if (jsonObject["tam_tru_tinh"] != null &&
        jsonObject["tam_tru_tinh"] != "") {
      temporaryAddress += jsonObject["tam_tru_tinh"];
    }

    var response = await http.post(
        Uri.parse("$POST_PERSONAL_INFO_AddInjectedPerson"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "id": (jsonObject["doi_tuong_id"] as double).toInt(),
          "fullName": jsonObject["ho_ten"],
          "birthday": jsonObject["ngay_sinh"],
          "gender": jsonObject["gioi_tinh"],
          "ethnicGroup": jsonObject["dan_toc_id"],
          "phonenumber": jsonObject["dien_thoai"],
          "homeAddress": homeAddress,
          "temporaryAddress": temporaryAddress
        }));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> sendHistoryList(List<HistoryVaccination> list) async {
    List<Map<String, dynamic>> l = [];
    list.forEach((e) {
      l.add({
        "id": e.lich_su_tiem_id,
        "momId": null,
        "injectedPersonId": _doi_tuong_id,
        "vaccineName": e.ten_vacxin,
        "antigen": e.khang_nguyen,
        "injectionDate": e.ngay_tiem,
        "orderOfInjection": e.thu_tu_mui_tiem,
        "vaccineBatch": e.lo_vacxin,
        "vaccinationFacility": e.co_so_tiem_chung,
        "status": e.trang_thai
      });
    });
    var response = await http.post(
        Uri.parse("$POST_HISTORY_VACCIN_AddInjectionSchedule"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(l));
    if (response.statusCode == 200) {
      return response.body;
    }
>>>>>>> dev-tu/vaccination-feature
  }

  static Future<dynamic> getHistoryList() async {
    return get("$host$historyList$_doi_tuong_id");
  }

  static Future<dynamic> createPassByToken(String phoneNo, String pass) async {
    return post("$host$create_password",
        body: json.encode({"phoneNumber": phoneNo, "password": pass}));
  }

  static Future<dynamic> changePassByToken(String phoneNo, String pass) async {
    return post("$host$recover_pass_by_sms$phoneNo",
        body: json.encode({"phoneNumber": phoneNo, "password": pass}));
  }

  static Future<dynamic> getOTPRecoveryPass(String phoneNo) async {
    return post("$host$recover_pass_by_sms$phoneNo");
  }

  static Future<dynamic> getMemberList() async {
    return get("$host$memberList");
  }

  static Future<dynamic> checkPhoneNo(phoneNo) async {
    return post("$host$otpCheck",
        body: json.encode({"phoneNumber": phoneNo, "deviceId": "webportal"}));
  }

  static Future<dynamic> activeOTP(phoneNo, otp) async {
    return post("$host$otpActive",
        body: json.encode({"phoneNumber": phoneNo, "otp": otp}));
  }

  static Future<dynamic> login(phoneNo, pass) async {
    return post("$host$auth",
        body: json.encode({
          "phoneNumber": phoneNo,
          "pass": pass,
          "osType": "",
          "osVersion": "",
          "deviceId": "",
          "notificationToken": ""
        }));
  }

  static Future<dynamic> get(String url) {
    var res = http.get(Uri.parse("$url"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
<<<<<<< HEAD
      'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty) ? 'Bearer $_tokenValue' : ''
=======
      'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty)
          ? 'Bearer $_tokenValue'
          : ''
>>>>>>> dev-tu/vaccination-feature
    });
    return handleResponse(res);
  }

  static Future<dynamic> post(String url, {Object body}) {
    var post = http.post(Uri.parse("$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
<<<<<<< HEAD
          'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty) ? 'Bearer $_tokenValue' : ''
=======
          'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty)
              ? 'Bearer $_tokenValue'
              : ''
>>>>>>> dev-tu/vaccination-feature
        },
        body: body);
    return handleResponse(post);
  }

  static Future<dynamic> handleResponse(Future<dynamic> response) async {
    try {
      final res = await response;
<<<<<<< HEAD
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 401) {
        res.body["code"] = 401;
        return res.body;
=======
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 401) {
        return '{"code": 401, "message": "${jsonDecode(res.body)["message"]}"}';
>>>>>>> dev-tu/vaccination-feature
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
