import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class GuidebookDetail extends StatefulWidget {
  final model;

  const GuidebookDetail(this.model);

  @override
  _GuidebookDetailState createState() => _GuidebookDetailState();
}

class _GuidebookDetailState extends State<GuidebookDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cẩm nang"),
        ),
        body: Stack(
          children: [
            Container(
              color: WHITE_COLOR,
              height: SizeConfig.blockSizeVertical * 100,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      color: BLACK_COLOR ,
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(
                          maxHeight: SizeConfig.blockSizeVertical * 45,
                        ),
                        child: Image(image: CachedNetworkImageProvider(
                          widget.model.imageURL,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 10, 8),
                    child: Text(
                      widget.model.title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 10, 6),
                      child: Row(
                        children: [
                          Text(
                            DateTimeConvert.timeAgoSinceDateWithDoW(widget.model.createTime),
                            style: TextStyle(color: LIGHT_DARK_GREY_COLOR),),
                          SizedBox(width: 6),
                          Icon(
                            Icons.fiber_manual_record,
                            color: GREY_COLOR,
                            size: 6,
                          ),
                          SizedBox(width: 6),
                          Text(
                            widget.model.estimatedFinishTime.toString() + " phút đọc",
                            style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
                          ),
                        ],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 8, 16),
                    child: Html(
                      data: widget.model.guidebookContent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

}
