import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  //for signOut
  Future sigOut() async {
    var result = await _authService.signOut();
    if (result == true) {
      _navigationService.replaceWith(Routes.authenticateViewRoute);
    }
  }

  //user data
  UserData _userData;
  //getter
  UserData get userData => _userData;
  //listen to firestore user data stream
  void listenToUserData() async {
    setBusy(true);
    User user = await _authService.userUIDAndEmail;
    _firestoreService
        .listenToUserDataRealTime(user.uid, user.email)
        .listen((result) {
      _userData = result;
      notifyListeners();
    });
    setBusy(false);
  }
}
