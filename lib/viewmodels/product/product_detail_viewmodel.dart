import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/barcode_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/home_index_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends ReactiveViewModel {
  SnackbarService _snackbarService = locator<SnackbarService>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  NavigationService _navigationService = locator<NavigationService>();
  BarcodeService _barcodeService = locator<BarcodeService>();
  DialogService _dialogService = locator<DialogService>();
  AuthService _authService = locator<AuthService>();
  HomeIndexService _homeIndexService = locator<HomeIndexService>();
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
    setBusy(true);
    if (result.confirmed) {
      var result = await _barcodeService.scanBarcode();
      //productRaw[0] = product type
      //productRaw[1] = product key
      //productRaw[2] = mac address of product
      List productRaw = result.split("_");
      //check lengt of product raw(type, key, mac address)
      if (productRaw.length == 3) {
        //cek is product exist?
        var isProductExist = await _realtimeDBService.isProductExist(
                productRaw[0], productRaw[1]) ??
            false;
        if (isProductExist) {
          //cek is product raw[2] is same as its mac adress in firestore
          var macAddressFromFirestore = await _realtimeDBService.getMacAddress(
              productRaw[0], productRaw[1]);
          if (productRaw[2] == macAddressFromFirestore) {
            //get uid
            User user = await _authService.userUIDAndEmail;
            //make combination from product key and product type
            String productKeyAndType = productRaw[1] + '_' + productRaw[0];
            //add
            bool isAdd = await _firestoreService.addProductToUser(
                user.uid, productKeyAndType);
            if (isAdd) {
              //subsribe to topic
              bool isSubscribe = await _pushNotificationService
                  .subscribeToTopic(productRaw[1]);
              //add notif status in local storage
              if (isSubscribe) {
                _localStorageService.setIsSubscribeToThisTopic(
                    productRaw[1], true);
              }

              //navigate to menu myproduct
              _navigationService.popUntil((route) => route.isFirst);
              //change home index to my product
              _homeIndexService.setIndex(1);
              //has been success
              _snackbarService.showSnackbar(
                  message: 'The process of adding items has successed.');
              setBusy(false);
              return true;
            } else {
              //has been failed
            }
          } else {
            //has been failed
          }
        } else {
          //has been failed
        }
      } else {
        //has been failed
      }
      print(result);
    } else {
      //has been canceled
      _snackbarService.showSnackbar(message: 'Scan has been canceled.');
      setBusy(false);
      return false;
    }
    //has been failed
    _snackbarService.showSnackbar(
        message: 'The process of adding items has failed.');
    setBusy(false);
    return false;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_homeIndexService];
}
