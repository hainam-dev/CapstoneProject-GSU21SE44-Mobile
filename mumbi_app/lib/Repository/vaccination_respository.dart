import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/history_vaccination.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
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
  static List<String> _doi_tuong_ids;
  static final _KEY_TOKEN = "vaccination_token";
  static final _KEY_DOI_TUONG_ID = "vaccination_doi_tuong_id";
  static final _KEY_PASSWORD_USER = "vaccination_password_user";
  static final _KEY_PHONE_USER = "vaccination_phone_user";

  static void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_KEY_PHONE_USER, "");
    sharedPreferences.setString(_KEY_PASSWORD_USER, "");
    sharedPreferences.setStringList(_KEY_DOI_TUONG_ID, []);
    sharedPreferences.setString(_KEY_TOKEN, "");
  }

  static Future<String> getPhoneUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_KEY_PHONE_USER);
  }

  static void setPhoneUser(String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_KEY_PHONE_USER, phone);
  }

  static Future<String> getPasswordUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_KEY_PASSWORD_USER);
  }

  static void setPasswordUser(String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_KEY_PASSWORD_USER, pass);
  }

  static Future<List<String>> getDoi_tuong_ids() async {
    if (_doi_tuong_ids == null || _doi_tuong_ids.isEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _doi_tuong_ids = sharedPreferences.getStringList(_KEY_DOI_TUONG_ID);
    }
    return _doi_tuong_ids;
  }

  static void setDoi_tuong_ids(List<String> ids) async {
    _doi_tuong_ids = ids == null ? [] : ids;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(_KEY_DOI_TUONG_ID, _doi_tuong_ids);
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
    sharedPreferences.setString(_KEY_TOKEN, _tokenValue);
  }

  static Future<dynamic> sendPersonalInfo(List data) async {
    List<dynamic> list = [];
    String momId = await UserViewModel.getUserID();
    data.forEach((e) {
      var homeAddress = "";
      if (e["ho_khau_dia_chi"] != null && e["ho_khau_dia_chi"] != "") {
        homeAddress += e["ho_khau_dia_chi"] + ", ";
      }

      if (e["ho_khau_thon_ap"] != null && e["ho_khau_thon_ap"] != "") {
        homeAddress += e["ho_khau_thon_ap"] + ", ";
      }

      if (e["ho_khau_xa"] != null && e["ho_khau_xa"] != "") {
        homeAddress += e["ho_khau_xa"] + ", ";
      }

      if (e["ho_khau_huyen"] != null && e["ho_khau_huyen"] != "") {
        homeAddress += e["ho_khau_huyen"];
      }

      if (e["ho_khau_tinh"] != null && e["ho_khau_tinh"] != "") {
        homeAddress += e["ho_khau_tinh"] + ", ";
      }

      var temporaryAddress = "";
      if (e["tam_tru_dia_chi"] != null && e["tam_tru_dia_chi"] != "") {
        temporaryAddress += e["tam_tru_dia_chi"] + ", ";
      }

      if (e["tam_tru_thon_ap"] != null && e["tam_tru_thon_ap"] != "") {
        temporaryAddress += e["tam_tru_thon_ap"] + ", ";
      }

      if (e["tam_tru_xa"] != null && e["tam_tru_xa"] != "") {
        temporaryAddress += e["tam_tru_xa"] + ", ";
      }

      if (e["tam_tru_huyen"] != null && e["tam_tru_huyen"] != "") {
        temporaryAddress += e["tam_tru_huyen"] + ", ";
      }

      if (e["tam_tru_tinh"] != null && e["tam_tru_tinh"] != "") {
        temporaryAddress += e["tam_tru_tinh"];
      }
      list.add({
        "momId": momId,
        "id": (e["doi_tuong_id"] as double).toInt(),
        "fullName": e["ho_ten"],
        "birthday": e["ngay_sinh"],
        "gender": e["gioi_tinh"],
        "ethnicGroup": e["ten_dan_toc"],
        //"identityCardNumber": e[""],
        "phonenumber": e["dien_thoai"],
        "homeAddress": homeAddress,
        "temporaryAddress": temporaryAddress
      });
    });

    try {
      var response = await http.post(
          Uri.parse("$POST_PERSONAL_INFO_AddInjectedPerson"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(list));
      print(response.request.toString());
      print(jsonEncode(list));
      print(
          "sendPersonalInfo: ${response.statusCode} ${response.reasonPhrase}");
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  static Future<dynamic> personListSynchronization() async {
    var value = await getMemberList();
    if (value != null) {
      var json = jsonDecode(value);
      if (json["code"] == 1) {
        List data = json["data"];
        if (data != null) {
          VaccinationRespository.setDoi_tuong_ids(data
              .map((e) => (e["doi_tuong_id"] as double).toInt().toString())
              .toList());
          var value1 = await sendPersonalInfo(data);
          print(value1);
        }
      }
    }
  }

  static Future<dynamic> historyListSynchronization() async {
    var doi_tuong_ids = await getDoi_tuong_ids();
    for (final e in doi_tuong_ids) {
      var res = await VaccinationRespository.getHistoryList(int.parse(e));
      if (res != null) {
        var jsonObject = jsonDecode(res);
        Iterable listHistory = jsonObject['data'];
        if (listHistory != null) {
          var res1 = await VaccinationRespository.sendHistoryList(
              listHistory.map((e) => HistoryVaccination.fromJson(e)).toList());
          print(res1);
        }
      }
    }
  }

  static Future<dynamic> sendHistoryList(List<HistoryVaccination> list) async {
    List<Map<String, dynamic>> l = [];
    String momId = await UserViewModel.getUserID();
    list.forEach((e) {
      l.add({
        "id": e.lich_su_tiem_id,
        "momId": momId,
        "injectedPersonId": e.doi_tuong_id,
        "vaccineName": e.ten_vacxin,
        "antigen": e.khang_nguyen,
        "injectionDate": e.ngay_tiem,
        "orderOfInjection": e.thu_tu_mui_tiem,
        "vaccineBatch": e.lo_vacxin,
        "vaccinationFacility": e.co_so_tiem_chung,
        "status": e.trang_thai
      });
    });
    try {
      var response = await http.post(
          Uri.parse("$POST_HISTORY_VACCIN_AddInjectionSchedule"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(l));
      print(response.request.toString());
      print(jsonEncode(l));
      print("sendHistoryList: ${response.statusCode} ${response.reasonPhrase}");
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  static Future<dynamic> getHistoryList(int doi_tuong_id) async {
    return get("$host$historyList$doi_tuong_id");
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
      'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty)
          ? 'Bearer $_tokenValue'
          : ''
    });
    return handleResponse(res);
  }

  static Future<dynamic> post(String url, {Object body}) {
    var post = http.post(Uri.parse("$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty)
              ? 'Bearer $_tokenValue'
              : ''
        },
        body: body);
    return handleResponse(post, body: body);
  }

  static Future<dynamic> handleResponse(Future<dynamic> response,
      {body}) async {
    try {
      var res = await response;
      //print(res.body);
      //print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 401) {
        var phone = await getPhoneUser();
        var pass = await getPasswordUser();
        var valueLogin = await login(phone, pass);
        final json = jsonDecode(valueLogin);
        //print(json);
        final success = json["code"] == 1;
        if (success) {
          setTokenValue(json["data"]["token"]);
          final method = res.request.method;
          final url = res.request.url;
          var future;
          if (method == "POST") {
            future = http.post(url,
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization':
                      (_tokenValue != null && _tokenValue.isNotEmpty)
                          ? 'Bearer $_tokenValue'
                          : ''
                },
                body: body);
          } else if (method == "GET") {
            future = http.get(url, headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': (_tokenValue != null && _tokenValue.isNotEmpty)
                  ? 'Bearer $_tokenValue'
                  : ''
            });
          }
          if (future != null) {
            res = await future;
            //print(res.body);
            //print(res.statusCode);
          } else {
            return '{"code": 0, "message": "Có lỗi xảy ra, vui lòng thử lại"}';
          }
          if (res.statusCode == 200) {
            return res.body;
          }
        }
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
