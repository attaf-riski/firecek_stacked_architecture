import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  //state for checkbox
  bool _isCheck = false;

  //setter _isCheck
  void setIsCek() {
    _isCheck = !_isCheck;
    notifyListeners();
  }

  //getter
  get getIsCheck => _isCheck;

  //sign up with firebase
  Future signUp(String email, String password) async {
    //for show loading ui
    setBusy(true);
    var result =
        await _authService.signUpWithEmail(email: email, password: password);
    if (result is User && result.uid != null) {
      //make firestore user data
      bool isHasBeenCreateUserData = await _firestoreService.createUserData(
          result.uid,
          'Insert Name',
          'https://firebasestorage.googleapis.com/v0/b/test-29074.appspot.com/o/profile.png?alt=media&token=7ca5df86-b63a-4654-adae-60e05ebe9c74',
          []);
      //isHasBeenCreateUserData true or false
      if (isHasBeenCreateUserData) {
        //for add fingerprint in settings
        await _secureStorageService.setCurrentPassword(password);
        //stop show loading ui
        setBusy(false);
        _navigationService.replaceWith(Routes.homeViewRoute,
            arguments: HomeViewArguments(
                isCheckBiometric: _isCheck,
                emailFromAuthenticate: email,
                passwordFromAuthenticate: password));
      } else {
        //fail make firestore user data account will delete
        print('CREATE USER DATA FAILED, ACCOUNT DELETED');
        await _authService.deleteAccount();
        //stop show loading ui
        setBusy(false);
        await _dialogService.showDialog(
          buttonTitle: 'Ok',
          title: 'Register Failed',
          description: 'Fail to create user data.',
          dialogPlatform: DialogPlatform.Material,
        );
      }
    } else if (result is String) {
      //stop show loading ui
      setBusy(false);
      await _dialogService.showDialog(
        buttonTitle: 'Ok',
        title: 'Register Failed',
        description: result,
        dialogPlatform: DialogPlatform.Material,
      );
    }
  }

  //cek is biometric has setup or not
  bool get isBiometricHasSetupped => _localStorageService.hasSetupBiometric;

  //has setuo dialog message
  void hasSetupMessage() async {
    await _dialogService.showDialog(
        dialogPlatform: DialogPlatform.Material,
        title: 'Fingerprint / face recognition login Has Been Used',
        description:
            'It has been used by another account. If you want use this account for fingerprint / face recognition login, try to reset fingerprint / face recognition login.Try this step\n1. Login with fingerprint / face recognition,\n2. Go to settings,\n3. Reset fingerprint / face recognition,\n4. Relogin with your new account and check use fingerprint / face recognition for login.');
  }
}
