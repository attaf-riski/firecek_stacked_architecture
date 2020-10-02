import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsWaterTankMonitorViewModel extends BaseViewModel {
  RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();

  //product key and its setter
  String _productKey;
  get productKey => _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifyListeners();
  }

  //update settings
  Future updateSettings({name, fixDistance, limit, volumeSet}) async {
    setBusy(true);
    bool result = await _realtimeDBService.updateSettingsWaterTankMonitor(
        _productKey, name, fixDistance, limit, volumeSet);
    if (result) {
      _navigationService.back(result: 'succes');
      _snackbarService.showSnackbar(message: 'Update success.');
    } else {
      _snackbarService.showSnackbar(message: 'Update fail.');
    }
  }

  //backbutton
  void backButton() {
    _navigationService.back();
  }

  //for searching volume
  searchVolume(String _widhtController, String _lengthController,
      {bool isReturnBool = true}) {
    try {
      int volume, width, length;
      bool isNotNullAnyone = true;
      if (_widhtController != '') {
        width = int.parse(_widhtController);
      } else {
        width = 0;
        isNotNullAnyone = false;
      }
      if (_lengthController != '') {
        length = int.parse(_lengthController);
      } else {
        length = 0;
        isNotNullAnyone = false;
      }
      volume = width * length;

      return (isReturnBool) ? isNotNullAnyone : volume;
    } catch (e) {
      print(e);
      return (isReturnBool) ? false : 0;
    }
  }
}
