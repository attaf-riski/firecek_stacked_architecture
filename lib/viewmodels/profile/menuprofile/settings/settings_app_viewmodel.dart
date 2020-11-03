import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/account_setting/account_settings_view.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/account_setting/change_password_view.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/account_setting/reset_password_view.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/appearance_setting/appearance_setting_view.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/appearance_setting/text_size_setting_view.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/security_setting/security_settings_view.dart';
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
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Reset',
        dialogPlatform: DialogPlatform.Material,
        title: 'Are you sure?',
        description: 'Are you sure reset the fingerprint for login?');
    if (result.confirmed) {
      //set the isHasSetupBiometric to true
      _localStorageService.hasSetupBiometric = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  //backButton
  backButton() {
    _navigationService.back();
  }

  //state
  bool _currentEmailEqualsBiometricEmail;
  //getter and setter
  get currentEmailEqualsBiometricEmail => _currentEmailEqualsBiometricEmail;

  //
  Future checkIsCurrentEmailEqualsBiometricEmail() async {
    String emailInBiometric = await _secureStorageService.emailBiometric;
    User currentUser = await _authService.userUIDAndEmail;
    //-1 / 1 is not equivalent
    //0 is equivalent
    _currentEmailEqualsBiometricEmail =
        emailInBiometric.compareTo(currentUser.email) == 0;
    notifyListeners();
  }

  //push to reset password
  pushToResetPassword() async {
    await _navigationService.navigateWithTransition(
        ResetPasswordView(inside: true),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
  }

  //push to reset password
  pushToChangePassword() async {
    await _navigationService.navigateWithTransition(ChangePasswordView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }

  //push to account settings
  pushToAccountSettings() async {
    await _navigationService.navigateWithTransition(AccountSettingsView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }

  //push to security settings
  pushToSecuritySettings() async {
    await _navigationService.navigateWithTransition(SecuritySettingsView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }

  //push to appearance setting
  pushToAppearanceSettings() async {
    await _navigationService.navigateWithTransition(AppearanceSettingsView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }

  //push to text size setting
  pushToTextSizeSetting() async {
    await _navigationService.navigateWithTransition(TextSizeSettingsView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }
}
