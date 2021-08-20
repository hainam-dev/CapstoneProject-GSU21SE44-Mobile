import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
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
  int currentPos = 0;
  List<String> getImages;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImages.forEach((url) {
        precacheImage(NetworkImage(url), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateTimeConvert.getDayOfWeek(widget.model.createTime) +
            DateTimeConvert.convertDatetimeFullFormat(widget.model.createTime)),
        actions: [
          editFlag == false ? MoreButton() : OkAndCancelButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            if (widget.model.imageURL != null && widget.model.imageURL != "")
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

  Widget PublicFunction() {
    return ListTile(
      leading: Image(
        image: AssetImage(community),
        height: 20,
        width: 20,
      ),
      title: Text(
        widget.model.publicFlag ? "Bỏ chia sẻ cộng đồng" : "Chia sẻ cộng đồng",
        style: TextStyle(color: YELLOW_COLOR),
      ),
      onTap: () async {
        Navigator.pop(context);
        showProgressDialogue(context);
        bool result = false;
        widget.model.publicDate = "1900-01-01T00:00:00.000";
        if (widget.model.publicFlag) {
          widget.model.publicFlag = false;
          widget.model.approvedFlag = false;
          result = await DiaryViewModel().updateDiary(widget.model);
        } else {
          widget.model.publicFlag = true;
          result = await DiaryViewModel().updateDiary(widget.model);
        }
        Navigator.pop(context);
        showResult(
            context,
            result,
            widget.model.publicFlag == false
                ? UN_PUBLIC_POST_MESSAGE
                : PUBLIC_POST_MESSAGE);
      },
    );
  }

  Widget EditFunction() {
    return ListTile(
      leading: Icon(Icons.create_outlined),
      title: Text("Chỉnh sửa nhật ký"),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          editFlag = true;
        });
      },
    );
  }

  Widget DeleteFunction() {
    return ListTile(
      leading: Icon(
        Icons.delete_outline,
        color: RED_COLOR,
      ),
      title: Text(
        "Xóa nhật ký",
        style: TextStyle(color: RED_COLOR),
      ),
      onTap: () async {
        Navigator.pop(context);
        showConfirmDialog(
            context, "Xóa nhật ký", "Bạn có muốn xóa nhật ký này?",
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

  Widget OkAndCancelButton() {
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
                if (widget.model.publicDate == null)
                  widget.model.publicDate = "1900-01-01T00:00:00.000";
                widget.model.publicFlag = false;
                widget.model.approvedFlag = false;
                result = await DiaryViewModel().updateDiary(widget.model);
                Navigator.pop(context);
                showResult(context, result, "Chỉnh sửa nhật ký thành công");
              },
              child: Icon(
                Icons.save_outlined,
                size: 35,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
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
              child: Icon(
                Icons.clear_outlined,
                size: 35,
                color: PINK_COLOR,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget DiaryContent() {
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

  Widget getDiaryImage(String _image) {
    getImages = _image.split(";");
    return Column(
      children: [
        Stack(children: [
          Card(
            child: CarouselSlider.builder(
              itemCount: getImages.length,
              options: CarouselOptions(
                  aspectRatio: 1,
                  autoPlay: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }),
              itemBuilder: (context, index, _) {
                return Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FullScreenWidget(
                      backgroundColor: WHITE_COLOR,
                      child: Center(
                        child: Hero(
                          tag: getImages[index].toString(),
                          child: Container(
                            child: Image.network(
                              getImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (editFlag)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        child: Icon(
                          Icons.cancel,
                          size: 30,
                          color: PINK_COLOR,
                        ),
                        onTap: () {
                          setState(() {
                            getImages.removeAt(index);
                            String url = "";
                            for (var getUrl in getImages) {
                              if (getUrl != getImages.last) {
                                url += getUrl + ";";
                              } else {
                                url += getUrl;
                              }
                            }
                            widget.model.imageURL = url;
                          });
                        },
                      ),
                    ),
                ]);
              },
            ),
          ),
          if (editFlag == false)
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 32.0,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: PINK_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  (currentPos + 1).toString() +
                      "/" +
                      getImages.length.toString(),
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getImages.map((pic) {
            int index = getImages.indexOf(pic);
            return Container(
              width: currentPos == index ? 8.0 : 4.0,
              height: currentPos == index ? 8.0 : 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPos == index
                    ? PINK_COLOR
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
