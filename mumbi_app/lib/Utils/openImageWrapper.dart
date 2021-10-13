import 'package:flutter/material.dart';
import 'package:mumbi_app/widgets/customGalleryPhotoWrapper.dart';
import 'package:mumbi_app/widgets/customLoading.dart';

void openImage(BuildContext context, int index, var listImage) {
  Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.white.withOpacity(0),
          pageBuilder: (BuildContext context, _, __) => GalleryPhotoWrapper(
                galleries: listImage,
                initalIndex: index,
                scrollDirection: Axis.horizontal,
                loadingBuilder: (context, event) => loadingProgress(),
              )));
}
