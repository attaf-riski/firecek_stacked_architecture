import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/services/barcode_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  SnackbarService _snackbarService = locator<SnackbarService>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  NavigationService _navigationService = locator<NavigationService>();
  BarcodeService _barcodeService = locator<BarcodeService>();
  DialogService _dialogService = locator<DialogService>();

  //product data
  Product _product;
  get product => _product;
  set product(Product product) {
    _product = product;
    notifyListeners();
  }

  //backbutton
  void backButton() {
    _navigationService.back();
  }

  //settings
  Future scanToAdd() async {
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Scan',
        dialogPlatform: DialogPlatform.Material,
        title: 'Need to Scan Product',
        description: 'To add product, you need to scan QR product.');
    if (result.confirmed) {
      var result = _barcodeService.scanBarcode();
      print(result);
    } else {
      _snackbarService.showSnackbar(message: 'Scan has been canceled.');
    }
    return false;
  }
}
