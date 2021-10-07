import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoWrapper extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initalIndex;
  final PageController pageController;
  final String galleries;
  final Axis scrollDirection;

  GalleryPhotoWrapper(
      {Key key,
      this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initalIndex,
      this.galleries,
      this.scrollDirection})
      : pageController = PageController(initialPage: initalIndex);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoWrapper();
  }
}

class _GalleryPhotoWrapper extends State<GalleryPhotoWrapper> {
  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initalIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listImage = widget.galleries.split(";");
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints:
              BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: listImage.length,
                loadingBuilder: widget.loadingBuilder,
                backgroundDecoration:
                    widget.backgroundDecoration as BoxDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
                scrollDirection: widget.scrollDirection,
              ),
              Positioned(
                right: SizeConfig.blockSizeHorizontal * 45,
                top: SizeConfig.blockSizeVertical * 7,
                child: Container(
                  width: 40.0,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    (currentIndex + 1).toString() +
                        "/" +
                        listImage.length.toString(),
                    style: TextStyle(fontSize: 15, color: WHITE_COLOR),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    List<String> listImage = widget.galleries.split(";");
    final item = listImage[index];
    return PhotoViewGalleryPageOptions(
        imageProvider: (CachedNetworkImageProvider(listImage[index])),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
        maxScale: PhotoViewComputedScale.contained * 1.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.toString()));
  }
}
