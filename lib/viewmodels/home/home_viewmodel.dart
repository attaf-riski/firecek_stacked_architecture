import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  //service intance
  final BiometricService _biometricService = locator<BiometricService>();
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();
  final DialogService _dialogService = locator<DialogService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  //boolean for isAuthenticate or not
  bool _isAuthenticate = false;

  Future biometricPopUp(
      {@required String emailFromAuthenticate,
      @required String passwordFromAuthenticate}) async {
    //get list biometric
    List<BiometricType> _biometricTypes =
        await _biometricService.getAvailableBiometric();
    _isAuthenticate =
        await _biometricService.authenticationWithBiometric(_biometricTypes);
    if (_isAuthenticate) {
      await _secureStorageService.setEmailBiometric(emailFromAuthenticate);
      await _secureStorageService
          .setPasswordBiometric(passwordFromAuthenticate);
      //set the isHasSetupBiometric to true
      _localStorageService.hasSetupBiometric = true;
    } else {
      _dialogService.showDialog(
          buttonTitle: 'Ok',
          title: 'Sorry',
          description:
              'Your biometric authenticate has failed.\nPlease try again in settings',
          dialogPlatform: DialogPlatform.Material);
    }
  }

  //backbutton
  Future<bool> backButton() async {
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Exit',
        dialogPlatform: DialogPlatform.Material,
        title: 'Are you sure?',
        description: 'Are you sure exit from firecek?');
    if (result.confirmed) {
      return true;
    }
    return false;
  }
}
