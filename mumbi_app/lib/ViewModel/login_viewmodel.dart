import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Repository/login_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginViewModel extends Model {
  LoginRepository _loginRepository = LoginRepository();
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  LoginViewModel({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<dynamic> signInWithGoogle() async {
    try {
      var response;
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('access' + googleAuth.accessToken);

      await _firebaseAuth.signInWithCredential(credential);
      var user = await _firebaseAuth.currentUser;
      if (user != null) {
        var token = await user.getIdToken();
        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
        var fcmToken = await _firebaseMessaging.getToken();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(FCM_TOKEN, fcmToken);
        print("idToken: " + token);
        print("fcmToken: " + fcmToken);
        response = await _loginRepository.callAPILoginGoogle(token, fcmToken);
        if (response != null) {
          /*
          UserModel userModel = UserModel.fromJson(jsonDecode(response));
          print(userModel.data.id);
          print(userModel.data.email);
          print(userModel.data.photo);
          print(userModel.data.role);
          print(response);*/
          return response;
        }
        notifyListeners();
      }
      return null;
    } catch (e) {
      print("signInWithGoogle Error: " + e.toString());
      signOut();
    }
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("UserInfo");
    storage.delete(key: "UserInfo");
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // Future<bool> isSignedIn() async {
  //   try {
  //     final user = await _firebaseAuth.currentUser;
  //     if (user != null) {
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser).email;
  }
}
