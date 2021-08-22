import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildHistory extends StatefulWidget {
  @override
  _ChildHistoryState createState() => _ChildHistoryState();
}

class _ChildHistoryState extends State<ChildHistory> {
  ChildViewModel childViewModel;
  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();
    childViewModel.getChildByID(CurrentMember.pregnancyFlag == true
        ? CurrentMember.pregnancyID
        : CurrentMember.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: childViewModel,
      child: ScopedModelDescendant(builder: (BuildContext context,Widget child,ChildViewModel model) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Lịch sử cập nhật thông tin"),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChildInfo(model.childModel),
              ],
            )
        );
      },),
    );
  }

  Widget ChildInfo(ChildModel childModel) {
    return ListTile(
        leading: childModel == null
            ? CircleAvatar(radius: 22, backgroundColor: LIGHT_GREY_COLOR)
            : CircleAvatar(
          radius: 22,
          backgroundColor: LIGHT_GREY_COLOR,
          backgroundImage:
          CachedNetworkImageProvider(childModel.imageURL),
        ),
        title: Text(
          childModel == null ? "..." : childModel.fullName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ));
  }
}
