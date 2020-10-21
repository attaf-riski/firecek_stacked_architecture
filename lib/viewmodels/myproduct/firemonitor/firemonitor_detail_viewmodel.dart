import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FireMonitorDetailViewModel extends StreamViewModel {
  RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  //initial data
  String _productName;
  get productName => _productName;
  void setProductName(String newName) {
    _productName = newName;
  }

  //data
  FireMonitor _fireMonitor;
  get fireMonitor => _fireMonitor;
  set fireMonitor(var dataJson) {
    _fireMonitor = FireMonitor.fromJson(map: dataJson);
    setProductName(_fireMonitor.productName);
  }

  //product key and its setter
  String _productKey = 'initialised';
  get productKey => _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifySourceChanged();
  }

  //back button
  void backButton() {
    _navigationService.back();
  }

  //update product name
  Future updateProductName(String newName) async {
    var result =
        await _realtimeDBService.updateFMProductName(productKey, newName);
    print('[UPDATE] updateProductName result:$result || new name:$newName');
  }

  //update zone name
  //zone 1
  Future updateZone(String zoneKey, String newName) async {
    var result =
        await _realtimeDBService.updateZoneName(productKey, newName, zoneKey);
    print(
        '[UPDATE] updateZone zone:$zoneKey || new name:$newName || result:$result');
  }

  //delete product in myProduct list current user
  User user;
  deleteProduct() async {
    user = await _authService.userUIDAndEmail;
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Delete',
        dialogPlatform: DialogPlatform.Material,
        title: 'Are you Sure?',
        description: 'Do you want to delete ' + fireMonitor.productName + ' ?');
    if (result.confirmed) {
      //delete
      var result = await _firestoreService.deleteProductFromUser(
          user.uid, productKey + '_' + FIREMONITORING);
      if (result == true) {
        //unsubscribe
        bool result =
            await _pushNotificationService.unsubscribeToTopic(productKey);
        //delete status in local storage
        if (result) {
          _localStorageService.setIsSubscribeToThisTopic(productKey, false);
          readLocalStorage();
        }
        //navigate to menu myproduct
        _navigationService.popUntil((route) => route.isFirst);
        //show snackbar
        _snackbarService.showSnackbar(
            message: fireMonitor.productName + ' has been deleted.');
        //refresh
        notifyListeners();
        return true;
      } else {
        //show snackbar
        _snackbarService.showSnackbar(
            message:
                fireMonitor.productName + ' Deleting product has been failed.');
      }
    } else {
      return false;
    }
  }

  //is notification enable or not
  bool _isNotificationEnabled = true;
  get isNotificationEnabled => _isNotificationEnabled;

  //set _isNotificationEnabled like notification status in local storage
  readLocalStorage() {
    _isNotificationEnabled =
        _localStorageService.isSubscribeToThisTopic(productKey);
    notifyListeners();
  }

  //toggle for notification
  toggleEnableAndDisableNotification() async {
    bool result = false;
    //set subscribe/unsubcribe to fcm
    (isNotificationEnabled)
        ? result = await _pushNotificationService.unsubscribeToTopic(productKey)
        : result = await _pushNotificationService.subscribeToTopic(productKey);
    //set notification menjadi kebalikan
    if (result) {
      _localStorageService.setIsSubscribeToThisTopic(
          productKey, !_isNotificationEnabled);
      readLocalStorage();
    }
  }

  @override
  Stream get stream =>
      _realtimeDBService.listenToFireMonitorRealTime(_productKey);
}
