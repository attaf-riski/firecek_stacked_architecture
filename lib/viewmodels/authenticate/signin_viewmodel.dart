import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();
  final BiometricService _biometricService = locator<BiometricService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  //state for checkbox
  bool _isCheck = false;

  //setter _isCheck
  void setIsCek() {
    _isCheck = !_isCheck;
    notifyListeners();
  }

  //getter for chechbox status
  get isCheck => _isCheck;

  //getter for check is biometric is don't have value or not
  bool get isHasSetupBiometric => _localStorageService.hasSetupBiometric;

  //boolean for isAuthenticate or not
  bool _isAuthenticate = false;

  Future biometricPopUp() async {
    //get list biometric
    List<BiometricType> _biometricTypes =
        await _biometricService.getAvailableBiometric();
    _isAuthenticate =
        await _biometricService.authenticationWithBiometric(_biometricTypes);
    if (_isAuthenticate) {
      //connect with signIn if authenticate true
      await signIn(loginWithFingerPrint: true);
    } else {
      _dialogService.showDialog(
          buttonTitle: 'Ok',
          title: 'Sorry',
          description:
              'Your biometric authenticate has failed. Please login manually.',
          dialogPlatform: DialogPlatform.Material);
    }
  }

  //sign in with firebase
  Future signIn(
      {String email,
      String password,
      bool loginWithFingerPrint = false}) async {
    //for show loading ui
    setBusy(true);
    var result;
    if (loginWithFingerPrint) {
      email = await _secureStorageService.emailBiometric;
      password = await _secureStorageService.passwordBiometric;
      result =
          await _authService.sigInWithEmail(email: email, password: password);
    } else {
      result =
          await _authService.sigInWithEmail(email: email, password: password);
    }

    if (result == true) {
      //set current password
      //for add fingerprint in settings
      await _secureStorageService.setCurrentPassword(password);
      //subscribe to all user product
      //take user data from firestore
      User user = await _authService.userUIDAndEmail;
      UserData userData =
          await _firestoreService.userDataFuture(user.uid, user.email);
      //take list myProduct from user data
      List productNameForTopic = userData.myProduct;
      //subscribe to topic with name of product user
      productNameForTopic.forEach((element) async {
        List productKey = element.split('_');
        //product key 0 = productKey
        //product key 1 = productType
        //
        //subscribe to all product in myProduct
        await _pushNotificationService.subscribeToTopic(productKey[0]);
        //set button on/off notif in myproduct detail to on all
        _localStorageService.setIsSubscribeToThisTopic(productKey[0], true);
      });
      //stop show loading
      setBusy(false);
      _navigationService.replaceWith(Routes.homeViewRoute,
          arguments: HomeViewArguments(
              isCheckBiometric: _isCheck,
              emailFromAuthenticate: email,
              passwordFromAuthenticate: password));
    } else if (result is String) {
      //stop show loading ui
      setBusy(false);
      await _dialogService.showDialog(
        title: 'Login Failed',
        description: result,
        dialogPlatform: DialogPlatform.Material,
      );
    }
  }
}
