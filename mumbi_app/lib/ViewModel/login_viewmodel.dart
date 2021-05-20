import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel extends Model {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  LoginViewModel({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future signInWithGoogle() async {
    try {
      //Trigger Authentication Flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print(googleUser);
      if (googleUser != null) {
        //Obtaining auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print(googleAuth);

        //Creating new credential
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        print(credential);
        await _firebaseAuth.signInWithCredential(credential);
        var user = await _firebaseAuth.currentUser();
        if(user != null){
          print(user.providerData);
          return user;
        }
      }
    } catch (e) {
      print(e);
      signOutGoogle();
    }
  }

  Future<void> signOutGoogle() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
