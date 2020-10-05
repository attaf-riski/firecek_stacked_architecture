import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsAppViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  BiometricService _biometricService = locator<BiometricService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  AuthService _authService = locator<AuthService>();
  SecureStorageService _secureStorageService = locator<SecureStorageService>();
  DialogService _dialogService = locator<DialogService>();

  //cek is biometric has setup or not
  bool get isBiometricHasSetupped => _localStorageService.hasSetupBiometric;

  //boolean for isAuthenticate or not
  bool _isAuthenticate = false;

  //add add biometric
  Future biometricPopUp() async {
    //get list biometric
    List<BiometricType> _biometricTypes =
        await _biometricService.getAvailableBiometric();
    _isAuthenticate =
        await _biometricService.authenticationWithBiometric(_biometricTypes);
    if (_isAuthenticate) {
      User user = await _authService.userUIDAndEmail;
      String currentPassword = await _secureStorageService.currentPassword;
      bool reaunthenticate = await _authService.reAuthenticate(currentPassword);
      if (reaunthenticate) {
        await _secureStorageService.setEmailBiometric(user.email);
        await _secureStorageService.setPasswordBiometric(currentPassword);
        //set the isHasSetupBiometric to true
        _localStorageService.hasSetupBiometric = true;
        notifyListeners();
      } else {
        _dialogService.showDialog(
            buttonTitle: 'Ok',
            title: 'Sorry',
            description: 'Your account password has changed.\nPlease Relogin.',
            dialogPlatform: DialogPlatform.Material);
      }
    } else {
      _dialogService.showDialog(
          buttonTitle: 'Ok',
          title: 'Sorry',
          description:
              'Your biometric authenticate has failed.\nPlease try again.',
          dialogPlatform: DialogPlatform.Material);
    }
  }

  //reset biometric
  Future resetBiometric() async {
    //set the isHasSetupBiometric to true
    _localStorageService.hasSetupBiometric = false;
    notifyListeners();
  }

  //backButton
  backButton() {
    _navigationService.back();
  }
}
