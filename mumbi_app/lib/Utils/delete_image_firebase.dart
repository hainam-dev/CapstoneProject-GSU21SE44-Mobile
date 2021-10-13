import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

Future<void> deleteImage(List<String> imageFileUrl) async {
  for (var imageURL in imageFileUrl) {
    var fileUrl = Uri.decodeFull(Path.basename(imageURL))
        .replaceAll(new RegExp(r'(\?alt).*'), '');

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }
}
