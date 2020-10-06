import 'dart:async';

import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:firecek_stacked_architecture/services/connectivity_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/reset_password_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticateViewModel extends ReactiveViewModel {
  final AuthToggleState _authToggleState = locator<AuthToggleState>();
  final DialogService _dialogService = locator<DialogService>();
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get isSignIn => _authToggleState.isSignIn;

  void toChangeView() {
    _authToggleState.toggleAuth();
  }

  //is Offline getter
  bool get isOffline => _connectivityService.isOffline;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_authToggleState, _connectivityService];

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

  //push to reset password
  pushToResetPassword() async {
    await _navigationService.navigateWithTransition(
        ResetPasswordView(inside: false),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
  }
}
