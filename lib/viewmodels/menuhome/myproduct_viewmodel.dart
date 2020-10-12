import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class MyProductViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  //user data
  UserData _userData;
  //getter
  UserData get userData => _userData;
  //listen to firestore user data stream
  Future listenToUserData() async {
    setBusy(true);
    User user = await _authService.userUIDAndEmail;
    _firestoreService
        .listenToUserDataRealTime(user.uid, user.email)
        .listen((result) {
      _userData = result;
      setBusy(false);
      notifyListeners();
    });
  }
}
