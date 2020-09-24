import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  
  //for get user is exist or not
  //if not, autheticate view will show
  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    return user != null;
  }
}
