import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePasswordViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  SecureStorageService _secureStorageService = locator<SecureStorageService>();

  //back button
  backButton() {
    _navigationService.back();
  }

  //update
  updatePassword(
      {String currentPassword, newPassword, againNewPassword}) async {
    print(currentPassword);
    print(newPassword);
    print(againNewPassword);
    //reauthenticate
    bool reauthenticate = await _authService.reAuthenticate(currentPassword);
    if (reauthenticate) {
      if (newPassword.length >= 6 && newPassword != '') {
        if (againNewPassword.compareTo(newPassword) == 0) {
          bool isUpdate = await _authService.updatePassword(againNewPassword);
          if (isUpdate) {
            //dialog
            _dialogService.showDialog(
                description: 'Please relogin.',
                title: "Password Has Been Updated",
                dialogPlatform: DialogPlatform.Material);
            //check is current email is equivalent with biometric email
            //chech is email is equivalent with biometric email
            //if true reset biometric
            String emailForBiometric =
                await _secureStorageService.emailBiometric;
            User currentUser = await _authService.userUIDAndEmail;
            if (emailForBiometric.compareTo(currentUser.email) == 0) {
              _localStorageService.hasSetupBiometric = false;
            }
          } else {
            //dialog
            _dialogService.showDialog(
                description: 'Something wrong. Please try again.',
                title: "Update Password Has Been Failed",
                dialogPlatform: DialogPlatform.Material);
          }
        } else {
          //dialog
          _dialogService.showDialog(
              description:
                  'Please check again retype password and match to new password.',
              title: "Retype New Password Doesn't Match",
              dialogPlatform: DialogPlatform.Material);
        }
      } else {
        //dialog
        _dialogService.showDialog(
            description: 'Please enter password 6+ character.',
            title: 'New Password Strong Enough',
            dialogPlatform: DialogPlatform.Material);
      }
    } else {
      //dialog
      _dialogService.showDialog(
          description: 'Please enter correct current password.',
          title: 'Current Password Wrong',
          dialogPlatform: DialogPlatform.Material);
    }
  }
}
