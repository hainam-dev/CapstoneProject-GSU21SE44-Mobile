import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

class InjectionDetail extends StatefulWidget {
  final model;

  const InjectionDetail(this.model);

  @override
  _InjectionDetailState createState() => _InjectionDetailState();
}

class _InjectionDetailState extends State<InjectionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết tiêm chủng'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InjectionTableDetail(),
            ],
          ),
        ));
  }

  Widget InjectionTableDetail() {
    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            BodyItem(Icon(Icons.bubble_chart_outlined), 'Tên Vaccine',
                widget.model.vaccineName),
            BodyItem(Icon(Icons.coronavirus_outlined), 'Kháng nguyên',
                widget.model.antigen),
            BodyItem(Icon(Icons.colorize), 'Mũi số',
                widget.model.orderOfInjection.toString()),
            BodyItem(Icon(Icons.access_time), 'Ngày tiêm',
                widget.model.injectionDateTime),
            BodyItem(Icon(Icons.location_on_outlined), 'Nơi tiêm',
                widget.model.vaccinationFacility),
            BodyItem(Icon(Icons.check_circle_outline), 'Đã tiêm', ""),
          ],
        ));
  }

  Widget HeaderItem(String name) {
    return ListTile(
        leading: Text(name,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: PINK_COLOR)));
  }

  Widget BodyItem(Icon icon, String name, String detail) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
            leading: icon,
            title: Text(name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            subtitle: detail == ""
                ? null
                : Text(
                    detail == null ? "..." : detail,
                    style: TextStyle(fontSize: 16),
                    textWidthBasis: TextWidthBasis.longestLine,
                  )),
      ],
    );
  }
}
