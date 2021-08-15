import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/diary_view.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';

class BabyDiaryDetails extends StatefulWidget {

  final model;

  BabyDiaryDetails(this.model);

  @override
  _BabyDiaryDetailsState createState() => _BabyDiaryDetailsState();
}

class _BabyDiaryDetailsState extends State<BabyDiaryDetails> {
  bool editFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(DateTimeConvert.getDayOfWeek(widget.model.createTime)
              + DateTimeConvert.convertDatetimeFullFormat(widget.model.createTime)),
          actions: [
            editFlag == false ? MoreButton() : OkAndCancelButton(),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              if(widget.model.imageURL != null)
              getDiaryImage(widget.model.imageURL),
              DiaryContent(),
            ],
          ),
        ),

    );
  }

  Widget MoreButton() {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            showModalBottom();
          },
          child: Icon(Icons.more_vert),
        ));
  }

  Future<dynamic> showModalBottom() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PublicFunction(),
              EditFunction(),
              DeleteFunction(),
            ],
          );
        });
  }

  Widget PublicFunction(){
    return ListTile(
      leading: Image(
        image: AssetImage(community),
        height: 20,
        width: 20,
      ),
      title: Text(widget.model.publicFlag ? "Bỏ chia sẻ cộng đồng" : "Chia sẻ cộng đồng",style: TextStyle(color: YELLOW_COLOR),),
      onTap: () async {
        Navigator.pop(context);
        showProgressDialogue(context);
        bool result = false;
        widget.model.publicDate = "1900-01-01T00:00:00.000";
        if(widget.model.publicFlag){
          widget.model.publicFlag = false;
          widget.model.approvedFlag = false;
          result = await DiaryViewModel().updateDiary(widget.model);
        }else{
          widget.model.publicFlag = true;
          result = await DiaryViewModel().updateDiary(widget.model);
        }
        Navigator.pop(context);
        showResult(context, result, widget.model.publicFlag == false ? UN_PUBLIC_POST_MESSAGE : PUBLIC_POST_MESSAGE);
      },
    );
  }

  Widget EditFunction(){
    return ListTile(
      leading: Icon(Icons.create_outlined),
      title: Text("Chỉnh sửa nhật ký"),
      onTap: (){
        Navigator.pop(context);
        setState(() {
          editFlag = true;
        });
      },
    );
  }

  Widget DeleteFunction() {
    return ListTile (
      leading: Icon(Icons.delete_outline,color: RED_COLOR,),
      title: Text("Xóa nhật ký",style: TextStyle(color: RED_COLOR),),
      onTap: () async {
        Navigator.pop(context);
        showConfirmDialog(context, "Xóa nhật ký", "Bạn có muốn xóa nhật ký này?",
            ContinueFunction: () async {
              Navigator.pop(context);
              showProgressDialogue(context);
              bool result = false;
              result = await DiaryViewModel().deleteDiary(widget.model.id);
              Navigator.pop(context);
              Navigator.pop(context);
              showResult(context, result, "Xóa nhật ký thành công");
            });
      },
    );
  }

  Widget OkAndCancelButton(){
    return Row(
      children: <Widget>[
        SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: PINK_COLOR,
              heroTag: "Ok",
              onPressed: () async {
                showProgressDialogue(context);
                setState(() {
                  editFlag = false;
                });
                bool result = false;
                if(widget.model.publicDate == null)
                  widget.model.publicDate = "1900-01-01T00:00:00.000";
                widget.model.publicFlag = false;
                widget.model.approvedFlag = false;
                result = await DiaryViewModel().updateDiary(widget.model);
                Navigator.pop(context);
                showResult(context, result, "Chỉnh sửa nhật ký thành công");
              },
              child: Icon(Icons.save_outlined,size: 35,),
            ),
          ),
        ),
        SizedBox(width: 15,),
        SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: WHITE_COLOR,
              heroTag: "Cancel",
              onPressed: () {
                setState(() {
                  editFlag = false;
                });
              },
              child: Icon(Icons.clear_outlined,size: 35,color: PINK_COLOR,),
            ),
          ),
        ),
        SizedBox(width: 15,),
      ],
    );
  }

  Widget DiaryContent(){
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.model.diaryContent,
            minLines: 1,
            maxLines: null,
            autofocus: editFlag,
            enabled: editFlag,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: "Nội dung nhật ký...",
              focusColor: LIGHT_PINK_COLOR,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                widget.model.diaryContent = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget getDiaryImage(String _image){
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image(image: CachedNetworkImageProvider(_image)),
      );
  }
}

