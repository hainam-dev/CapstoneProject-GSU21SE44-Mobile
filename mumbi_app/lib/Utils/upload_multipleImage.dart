import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<String>> uploadMultipleImage(
    {@required String fileName,
    @required String thread,
    @required List<File> files}) async {
  List<String> uploadUrls = [];

  await Future.wait(
    files.map((File file) async {
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf(new RegExp(r'.png'));
      final splitted = filePath.substring(0, (lastIndex));

      final outPath = "${splitted}.jpg";
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 30,
      );
      String imageName = thread +
          "/" +
          fileName +
          outPath.substring(filePath.lastIndexOf(new RegExp(r'/')));
      if (file != null) {
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('UserImages/$imageName');
        UploadTask uploadTask = firebaseStorageRef.putFile(result);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await firebaseStorageRef.getDownloadURL();
        uploadUrls.add(url);
      }
    }),
  );
  if (uploadUrls.isNotEmpty) {
    return uploadUrls;
  }
  return null;
}
