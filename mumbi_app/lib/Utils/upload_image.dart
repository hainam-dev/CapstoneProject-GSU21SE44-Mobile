import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<String> uploadImageToFirebase(String username) async {
  Directory tempDir =
  await getTemporaryDirectory(); //tạo đường dẫn temp của máy
  String tempPath = tempDir.path; // lấy ra đường dẫn
  File _imageFile = File('$tempPath/($username) Update_image'); //tạo file temp
  Uint8List bytes;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String fileContentBase64 = prefs.getString('UserImage');
  bytes = base64.decode(fileContentBase64);
  print(bytes);
  await _imageFile.writeAsBytesSync(bytes);
  print(_imageFile);
  if (_imageFile != null) {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('UserAvatar/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await firebaseStorageRef.getDownloadURL();
    return url;
  }
  return null;
}