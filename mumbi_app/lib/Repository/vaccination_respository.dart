import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
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
    sharedPreferences.setString(_KEY_TOKEN, token);
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
      'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty) ? 'Bearer $_tokenValue' : ''
    });
    return handleResponse(res);
  }

  static Future<dynamic> post(String url, {Object body}) {
    var post = http.post(Uri.parse("$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty) ? 'Bearer $_tokenValue' : ''
        },
        body: body);
    return handleResponse(post);
  }

  static Future<dynamic> handleResponse(Future<dynamic> response) async {
    try {
      final res = await response;
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 401) {
        res.body["code"] = 401;
        return res.body;
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
