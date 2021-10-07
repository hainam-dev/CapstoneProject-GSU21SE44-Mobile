import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'dart:ui' as ui;

import 'customGalleryPhotoWrapper.dart';

class CustomGridLayoutPhoto extends StatefulWidget {
  final listImage;

  const CustomGridLayoutPhoto(this.listImage);
  @override
  _CustomGridLayoutPhotoState createState() => _CustomGridLayoutPhotoState(listImage);
}

class _CustomGridLayoutPhotoState extends State<CustomGridLayoutPhoto> {
  int imageWidth = 0;
  int imageHeight = 0;
  int currentIndex = 0;
  String listImage = "";
  GestureTapCallback onTap;
  _CustomGridLayoutPhotoState(this.listImage);
  @override
  Widget build(BuildContext context) {
    return getPostImage(listImage);
  }

  Widget getPostImage(String _image) {
    List<String> getImages = _image.split(";");
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().initConfig(constraints, orientation);
            return getImages.length == 1
                ? _buildGridLayoutOnlyPhoto(getImages)
                : getImages.length == 2
                    ? _buildGridLayoutTwoPhoto(getImages)
                    : getImages.length == 3
                        ? _buildGridLayoutThreePhoto(getImages)
                        : getImages.length == 4
                            ? _buildGridLayoutFourPhoto(getImages)
                            : _buildGridLayoutGreaterThanFourPhoto(getImages);
          },
        );
      },
    );
  }

  _buildGridLayoutOnlyPhoto(List<String> listImage) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listImage.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              GestureTapCallback:
              _openImage(context, index);
            },
            child: Hero(
              tag: listImage[index].toString(),
              child: CachedNetworkImage(
                  fit: BoxFit.cover, imageUrl: listImage[index]),
            ));
      },
    );
  }

  _buildGridLayoutTwoPhoto(List<String> listImage) {
    _calculateImageDimension(listImage[0]);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeHorizontal * 100,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection:
            imageWidth > imageHeight ? Axis.vertical : Axis.horizontal,
        itemCount: listImage.length,
        itemBuilder: (BuildContext context, int index) {
          return imageWidth > imageHeight
              ? Column(
                  children: [
                    Container(
                      height: SizeConfig.blockSizeHorizontal * 50,
                      child: GestureDetector(
                          onTap: () {
                            GestureTapCallback:
                            _openImage(context, index);
                          },
                          child: Hero(
                            tag: listImage[index].toString(),
                            child: CachedNetworkImage(
                                height: SizeConfig.blockSizeVertical * 100,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                fit: BoxFit.cover,
                                imageUrl: listImage[index]),
                          )),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: GestureDetector(
                        onTap: () {
                          GestureTapCallback:
                          _openImage(context, index);
                        },
                        child: Hero(
                          tag: listImage[index].toString(),
                          child: CachedNetworkImage(
                            imageUrl: listImage[index],
                            imageBuilder: (context, imageProvider) => Container(
                              height: SizeConfig.blockSizeVertical * 100,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.0,
                    )
                  ],
                );
        },
      ),
    );
  }

  _buildGridLayoutThreePhoto(List<String> listImage) {
    _calculateImageDimension(listImage[0]);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeHorizontal * 100,
      child: imageWidth > imageHeight
          ? Column(
              children: [
                Container(
                  height: SizeConfig.blockSizeHorizontal * 49,
                  child: GestureDetector(
                    onTap: () {
                      GestureTapCallback:
                      _openImage(context, 0);
                    },
                    child: Hero(
                      tag: listImage[0].toString(),
                      child: CachedNetworkImage(
                        imageUrl: listImage[0],
                        height: SizeConfig.blockSizeVertical * 100,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Container(
                  height: SizeConfig.blockSizeHorizontal * 49,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listImage.length - 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeHorizontal * 50,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: GestureDetector(
                                onTap: () {
                                  GestureTapCallback:
                                  _openImage(context, index + 1);
                                },
                                child: Hero(
                                  tag: listImage[index + 1].toString(),
                                  child: CachedNetworkImage(
                                    imageUrl: listImage[index + 1],
                                    height: SizeConfig.blockSizeVertical * 100,
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.0,
                            )
                          ],
                        );
                      }),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 49,
                  child: GestureDetector(
                    onTap: () {
                      GestureTapCallback:
                      _openImage(context, 0);
                    },
                    child: Hero(
                      tag: listImage[0].toString(),
                      child: CachedNetworkImage(
                        imageUrl: listImage[0],
                        height: SizeConfig.blockSizeVertical * 100,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 49,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listImage.length - 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeHorizontal * 50,
                              child: GestureDetector(
                                onTap: () {
                                  GestureTapCallback:
                                  _openImage(context, index + 1);
                                },
                                child: Hero(
                                  tag: listImage[index + 1].toString(),
                                  child: CachedNetworkImage(
                                    imageUrl: listImage[index + 1],
                                    height: SizeConfig.blockSizeVertical * 100,
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
    );
  }

  _buildGridLayoutFourPhoto(List<String> listImage) {
    _calculateImageDimension(listImage[0]);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeHorizontal * 100,
      child: imageWidth > imageHeight
          ? Column(
              children: [
                Container(
                  height: SizeConfig.blockSizeHorizontal * 66,
                  child: GestureDetector(
                    onTap: () {
                      GestureTapCallback:
                      _openImage(context, 0);
                    },
                    child: CachedNetworkImage(
                      imageUrl: listImage[0],
                      height: SizeConfig.blockSizeVertical * 100,
                      width: SizeConfig.blockSizeHorizontal * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Container(
                  height: SizeConfig.blockSizeHorizontal * 33,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listImage.length - 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 33,
                              child: GestureDetector(
                                onTap: () {
                                  GestureTapCallback:
                                  _openImage(context, index + 1);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: listImage[index + 1],
                                  height: SizeConfig.blockSizeVertical * 100,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.0,
                            )
                          ],
                        );
                      }),
                ),
              ],
            )
          : imageWidth < imageHeight
              ? Row(
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 66,
                      child: GestureDetector(
                        onTap: () {
                          GestureTapCallback:
                          _openImage(context, 0);
                        },
                        child: CachedNetworkImage(
                          imageUrl: listImage[0],
                          height: SizeConfig.blockSizeVertical * 100,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 33,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listImage.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  height: SizeConfig.blockSizeHorizontal * 33,
                                  child: GestureDetector(
                                    onTap: () {
                                      GestureTapCallback:
                                      _openImage(context, index + 1);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: listImage[index + 1],
                                      height:
                                          SizeConfig.blockSizeVertical * 100,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                )
              : Column(
                  children: [
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                      children: List.generate(listImage.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            GestureTapCallback:
                            _openImage(context, index);
                          },
                          child: CachedNetworkImage(
                            imageUrl: listImage[index],
                            height: SizeConfig.blockSizeVertical * 100,
                            width: SizeConfig.blockSizeHorizontal * 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
    );
  }

  _buildGridLayoutGreaterThanFourPhoto(List<String> listImage) {
    _calculateImageDimension(listImage[0]);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: imageWidth == imageHeight
          ? SizeConfig.blockSizeHorizontal * 84
          : SizeConfig.blockSizeHorizontal * 100,
      child: imageWidth > imageHeight
          ? Column(
              children: [
                Container(
                  height: SizeConfig.blockSizeHorizontal * 66,
                  child: GestureDetector(
                    onTap: () {
                      GestureTapCallback:
                      _openImage(context, 0);
                    },
                    child: Hero(
                      tag: listImage[0].toString(),
                      child: CachedNetworkImage(
                        imageUrl: listImage[0],
                        height: SizeConfig.blockSizeVertical * 100,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Container(
                  height: SizeConfig.blockSizeHorizontal * 33,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 33,
                              child: index < 2
                                  ? GestureDetector(
                                      onTap: () {
                                        GestureTapCallback:
                                        _openImage(context, index + 1);
                                      },
                                      child: Hero(
                                        tag: listImage[index + 1].toString(),
                                        child: CachedNetworkImage(
                                          imageUrl: listImage[index + 1],
                                          height: SizeConfig.blockSizeVertical *
                                              100,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        GestureTapCallback:
                                        _openImage(context, index + 1);
                                      },
                                      child: Stack(children: <Widget>[
                                        Hero(
                                          tag: listImage[index + 1].toString(),
                                          child: CachedNetworkImage(
                                            imageUrl: listImage[index + 1],
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    100,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          child: Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    100,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    100,
                                            decoration: BoxDecoration(
                                              color: Colors.black45,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "+" +
                                                    (listImage.length - 4)
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                            ),
                            SizedBox(
                              width: 3.0,
                            )
                          ],
                        );
                      }),
                ),
              ],
            )
          : imageWidth < imageHeight
              ? Row(
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 66,
                      child: GestureDetector(
                        onTap: () {
                          GestureTapCallback:
                          _openImage(context, 0);
                        },
                        child: Hero(
                          tag: listImage[0].toString(),
                          child: CachedNetworkImage(
                            imageUrl: listImage[0],
                            height: SizeConfig.blockSizeVertical * 100,
                            width: SizeConfig.blockSizeHorizontal * 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 33,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  height: SizeConfig.blockSizeHorizontal * 33,
                                  child: FullScreenWidget(
                                    backgroundIsTransparent: true,
                                    child: index < 2
                                        ? GestureDetector(
                                            onTap: () {
                                              GestureTapCallback:
                                              _openImage(context, index + 1);
                                            },
                                            child: Hero(
                                              tag: listImage[index + 1]
                                                  .toString(),
                                              child: CachedNetworkImage(
                                                imageUrl: listImage[index + 1],
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    100,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              GestureTapCallback:
                                              _openImage(context, index + 1);
                                            },
                                            child: Stack(children: <Widget>[
                                              Hero(
                                                tag: listImage[index + 1]
                                                    .toString(),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      listImage[index + 1],
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      100,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                child: Container(
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      100,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "+" +
                                                          (listImage.length - 4)
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeHorizontal * 49,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Container(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 50,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 50,
                                      child: GestureDetector(
                                        onTap: () {
                                          GestureTapCallback:
                                          _openImage(context, index);
                                        },
                                        child: Hero(
                                          tag: listImage[index].toString(),
                                          child: CachedNetworkImage(
                                            imageUrl: listImage[index],
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    100,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    )
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeHorizontal * 33,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Container(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 33,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 33,
                                      child: FullScreenWidget(
                                        backgroundIsTransparent: true,
                                        child: index < 2
                                            ? GestureDetector(
                                                onTap: () {
                                                  GestureTapCallback:
                                                  _openImage(
                                                      context, index + 2);
                                                },
                                                child: Hero(
                                                  tag: listImage[index + 2]
                                                      .toString(),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        listImage[index + 2],
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        100,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Stack(children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    GestureTapCallback:
                                                    _openImage(
                                                        context, index + 2);
                                                  },
                                                  child: Hero(
                                                    tag: listImage[index + 2]
                                                        .toString(),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          listImage[index + 2],
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          100,
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Container(
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        100,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black45,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "+" +
                                                            (listImage.length -
                                                                    4)
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    )
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
    );
  }

  void _calculateImageDimension(String imageURL) {
    new CachedNetworkImageProvider(imageURL)
        .resolve(ImageConfiguration())
        .addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            imageWidth = info.image.width.toInt();
            imageHeight = info.image.height.toInt();
          });
        });
      }),
    );
  }

  void _openImage(BuildContext context, final int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GalleryPhotoWrapper(
                  galleries: listImage,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  initalIndex: index,
                  scrollDirection: Axis.horizontal,
                )));
  }
}
