import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //for get user is exist or not
  //if not, autheticate view will show
  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  //get user uid and email information
  Future<User> get userUIDAndEmail async {
    var result = await _firebaseAuth.currentUser();
    return User(uid: result.uid, email: result.email);
  }

  //signin to firebase
  Future sigInWithEmail(
      {@required String email, @required String password}) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          return 'Email invalid';
        case 'ERROR_WRONG_PASSWORD':
          return 'Password is wrong';
        case 'ERROR_USER_NOT_FOUND':
          return 'Account not found';
        case 'ERROR_TOO_MANY_REQUESTS':
          return 'To many login with this account';
        case 'ERROR_USER_DISABLED':
          return 'Your account has been disable';
        case 'ERROR_OPERATION_NOT_ALLOWED':
          return 'Your account has been disable';
        default:
          return e.message;
      }
    }
  }

  //signup to firebase
  Future signUpWithEmail(
      {@required String email, @required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          return 'email invalid';
        case 'ERROR_WEAK_PASSWORD':
          return 'Your password is strong enough';
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          return 'email already use by another account';
        default:
          return e.message;
      }
    }
  }

  //signout
  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
  }
}
