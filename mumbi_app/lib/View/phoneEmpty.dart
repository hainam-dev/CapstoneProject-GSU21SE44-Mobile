import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Model/history_vaccination.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

import 'injectionVaccinationLogin_view.dart';

class PhoneEmpty extends StatefulWidget {
  const PhoneEmpty({Key key}) : super(key: key);

  @override
  _PhoneEmptyState createState() => _PhoneEmptyState();
}

class _PhoneEmptyState extends State<PhoneEmpty> {
  List<HistoryVaccination> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // list.add(HistoryVaccination.fromJson({
    //   "lich_su_tiem_id": 194337730.0,
    //   "doi_tuong_id": 28806313.0,
    //   "vacxin_id": 111.0,
    //   "ten_vacxin": "GC FLU Pre-filled Syringe",
    //   "khang_nguyen": "Cúm",
    //   "trang_thai": 2,
    //   "ngay_tiem": "10:30 09/06/2021",
    //   "thu_tu_mui_tiem": 1,
    //   "co_so_tiem_chung":
    //       "PHÒNG KHÁM TƯ VẤN VÀ ĐIỀU TRỊ DỰ PHÒNG - TTYTDP TP.HCM",
    //   "seo": null,
    //   "truoc_24h": null,
    //   "lo_vacxin": null,
    //   "phan_ung_sau_tiem": {
    //     "ngay_phan_ung": null,
    //     "loai_phan_ung": "Không có phản ứng",
    //     "ket_qua": null
    //   }
    // }));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showCustomProgressDialog(context, VaccinationRespository.getHistoryList(),
          (data) {
        var jsonObject = jsonDecode(data);
        //print("getHistoryList: $jsonObject");
        var succ = false;
        if (jsonObject["code"] == 401) {
          VaccinationRespository.setTokenValue(null);
          showCustomProgressDialog(context, null, (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InectionVaccinationLogin()),
            );
            return Pair(succ, jsonObject["message"]);
          });
        } else {
          succ = jsonObject["code"] == 1;
          if (succ) {
            Iterable listData = jsonObject['data'];
            list = listData
                .map((model) => HistoryVaccination.fromJson(model))
                .toList();
            VaccinationRespository.sendHistoryList(list).then((value) {
              print("sendHistoryList: $value");
            });
            setState(() {});
          }
        }
        return Pair(succ, jsonObject["message"]);
      });
    });
  }

  Widget buildList() {
    if (list.isEmpty) {
      return Center(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(emptyPhone),
            Text("Số điện thoại của bạn chưa có trong dữ liệu")
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          final item = list[i];
          return ListTile(
            leading: Container(
              height: double.infinity,
              child: CircleAvatar(
                backgroundColor: getColorFromHex("#9aca40"),
                child: Text(
                  item.thu_tu_mui_tiem.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            title: Text(
              item.ten_vacxin,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              children: [
                Container(
                  child: Text(
                    item.co_so_tiem_chung,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  child: Row(children: [
                    Text("●  "),
                    Text(
                      item.ngay_tiem,
                      style: TextStyle(fontSize: 12),
                    )
                  ]),
                )
              ],
            ),
            trailing: Container(
              height: double.infinity,
              child: Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  Text(
                    item.getTrangThai(),
                    style: TextStyle(
                        color: getColorFromHex("#9aca40"), fontSize: 15),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch Tiêm chủng"),
        leading: backButton(context, InjectionSchedule()),
      ),
      body: Container(child: buildList()),
    );
  }
}
