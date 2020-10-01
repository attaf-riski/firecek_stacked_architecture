import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/services/barcode_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MenuMyProductDetailViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  BarcodeService _barcodeService = locator<BarcodeService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  //for the data
  WaterTankMonitor _waterTankMonitor;
  set waterTankMonitor(WaterTankMonitor waterTankMonitor) {
    _waterTankMonitor = waterTankMonitor;
    notifyListeners();
  }

  Future pushToSetting() async {
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Scan',
        dialogPlatform: DialogPlatform.Material,
        title: 'Need to Scan Password',
        description: 'To open settings, you need to scan QR password.');
    if (result.confirmed) {
      //scan and result
      var result = await _barcodeService.scanBarcode();
      //cek is result and password same or not
      if (result == _waterTankMonitor.password) {
        _snackbarService.showSnackbar(message: 'scan success');
      } else {
        _snackbarService.showSnackbar(message: 'scan failed');
      }
      return false;
    }
  }
}
