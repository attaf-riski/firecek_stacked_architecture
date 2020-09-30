import 'dart:async';

import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:firecek_stacked_architecture/services/connectivity_service.dart';
import 'package:firecek_stacked_architecture/shared/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticateViewModel extends ReactiveViewModel {
  final AuthToggleState _authToggleState = locator<AuthToggleState>();
  final DialogService _dialogService = locator<DialogService>();
  static ConnectivityService _connectivityService =
      locator<ConnectivityService>();
  bool get isSignIn => _authToggleState.isSignIn;

  void toChangeView() {
    _authToggleState.toggleAuth();
  }

  ///////////////////////update for future////////////////////////
  /////ide//////
  ///1. masukan ke class sendiri
  ///2. reactive value
  ///3. kita tinggal ambil status is offline saja
  //state for check is offline or not
  bool _isOffline = false;
  //is Offline getter
  bool get isOffline => _isOffline;
  set isOffline(bool value) {
    _isOffline = value;
    notifyListeners();
  }

  //inisialisasi in the first
  void initialise() {
    _connectivityService.stream.listen((incomingData) {
      if (incomingData == ConnectivityStatus.Offline) {
        isOffline = true;
      } else {
        isOffline = false;
      }
      print(
          '(TRACE) AuthenticateViewModel:_streamToConnectivityService. _isOffline: $_isOffline');
    });
  }
  ///////////////////////update for future////////////////////////

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authToggleState];

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
