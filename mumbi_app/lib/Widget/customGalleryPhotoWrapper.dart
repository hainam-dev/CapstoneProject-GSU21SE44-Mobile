import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoWrapper extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final dynamic minScale;
  final dynamic maxScale;
  final int initalIndex;
  final PageController pageController;
  final String galleries;
  final Axis scrollDirection;

  GalleryPhotoWrapper(
      {Key key,
      this.loadingBuilder,
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
  double initialPositionY = 0;

  double currentPositionY = 0;

  double positionYDelta = 0;

  double opacity = 1;

  double disposeLimit = 150;

  Duration animationDuration;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initalIndex;
    setDisposeLevel();
    animationDuration = Duration.zero;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  setDisposeLevel() {
    setState(() {
      disposeLimit = 100;
    });
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY - initialPositionY;
      setOpacity();
    });
  }

  setOpacity() {
    double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 1000) * -1)
        : 1 - (positionYDelta / 1000);

    if (tmp > 1)
      opacity = 1;
    else if (tmp < 0)
      opacity = 0;
    else
      opacity = tmp;

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.5;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = Duration(milliseconds: 100);
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_) {
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listImage = widget.galleries.split(";");
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragStart: (details) => _startVerticalDrag(details),
        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        onVerticalDragEnd: (details) => _endVerticalDrag(details),
        child: Container(
            color: Colors.black.withOpacity(opacity),
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: SizeConfig.blockSizeVertical * 6,
                  child: Text(
                    (currentIndex + 1).toString() +
                        "/" +
                        listImage.length.toString(),
                    style: TextStyle(fontSize: 15, color: GREY_COLOR),
                  ),
                ),
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: Curves.fastOutSlowIn,
                  top: 0 + positionYDelta,
                  bottom: 0 - positionYDelta,
                  left: 0,
                  right: 0,
                  child: PhotoViewGallery.builder(
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent),
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: _buildItem,
                    itemCount: listImage.length,
                    loadingBuilder: widget.loadingBuilder,
                    pageController: widget.pageController,
                    onPageChanged: onPageChanged,
                    scrollDirection: widget.scrollDirection,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    List<String> listImage = widget.galleries.split(";");
    final item = listImage[index];
    return PhotoViewGalleryPageOptions(
        imageProvider: (CachedNetworkImageProvider(listImage[index])),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 30),
        maxScale: PhotoViewComputedScale.contained * 2,
        heroAttributes: PhotoViewHeroAttributes(tag: item.toString()));
  }
}
