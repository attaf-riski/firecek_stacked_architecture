import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ResetPasswordViewModel extends BaseViewModel {
  AuthService _authService = locator<AuthService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  SecureStorageService _secureStorageService = locator<SecureStorageService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  //back button
  backButton() {
    _navigationService.back();
  }

  //email
  String _email;
  get getEmail => _email;

  //load current email and set to _email
  loadCurrentEmail() async {
    setBusy(true);
    await _authService.userUIDAndEmail.then((value) => _email = value.email);
    notifyListeners();
    setBusy(false);
  }

  //send to link
  sendLinkToEmail(String email) async {
    if (email == '') {
      email = getEmail;
    }
    var result = await _authService.sendPasswordResetEmail(email);
    if (result is String) {
      _dialogService.showDialog(
          description: result,
          title: 'Sending Link Failed',
          dialogPlatform: DialogPlatform.Material);
    } else {
      //chech is email is equivalent with biometric email
      //if true reset biometric
      String emailForBiometric = await _secureStorageService.emailBiometric;
      if (emailForBiometric.compareTo(email) == 0) {
        _localStorageService.hasSetupBiometric = false;
      }
      //dialog
      _dialogService.showDialog(
          description: 'Please check message in $email.',
          title: 'Sending Link Success',
          dialogPlatform: DialogPlatform.Material);
    }
  }
}
