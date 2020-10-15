import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/history.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/barcode_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/history_view.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertankmonitor/settings_watertankmonitor_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MenuWaterTankMonitorViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  BarcodeService _barcodeService = locator<BarcodeService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  //product key and its setter
  String _productKey;
  get productKey => _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifyListeners();
  }

  //for the data
  WaterTankMonitor _waterTankMonitor;
  set waterTankMonitor(WaterTankMonitor waterTankMonitor) {
    _waterTankMonitor = waterTankMonitor;
    notifyListeners();
  }

  //settings
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
        await _navigationService.navigateWithTransition(
            SettingsWaterTankMonitorView(
              productKey: _productKey,
              waterTankMonitor: _waterTankMonitor,
            ),
            duration: fastDurationTransition,
            transition: 'rightToLeft');
      } else {
        _snackbarService.showSnackbar(message: 'Scan has been canceled.');
      }
      return false;
    }
  }

  //map acak to map rapi
  _sortedHistoryFromNewest() {
    if (_waterTankMonitor.history is Map) {
      //take from snapshot to Map
      Map<dynamic, dynamic> historiesMap = _waterTankMonitor.history;
      //change from map to list
      List<HistoryModel> historiesList = [];
      historiesMap.forEach((key, value) {
        historiesList.add(HistoryModel(
            date: value['date'],
            event: value['event'],
            timeStamp: value['timestamp']));
      });

      //sorting list
      historiesList.sort((a, b) {
        return a.timeStamp
            .toString()
            .toLowerCase()
            .compareTo(b.timeStamp.toString().toLowerCase());
      });
      //reversed
      //intialize a new list from iterable to the items of reversed order
      var reversedhistoriesList = new List.from(historiesList.reversed);
      return reversedhistoriesList;
    } else {
      return [];
    }
  }

  //push to history
  Future pushToHistory() async {
    var result = _sortedHistoryFromNewest();
    await _navigationService.navigateWithTransition(
        HistoryView(
          productHistory: result,
        ),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
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

  //delete product in myProduct list current user
  User user;
  deleteProduct() async {
    user = await _authService.userUIDAndEmail;
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Delete',
        dialogPlatform: DialogPlatform.Material,
        title: 'Are you Sure?',
        description: 'Do you want to delete ' + _waterTankMonitor.name + ' ?');
    if (result.confirmed) {
      //delete
      var result = await _firestoreService.deleteProductFromUser(
          user.uid, productKey + '_' + WATERTANKMONITORING);
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
            message: _waterTankMonitor.name + ' has been deleted.');
        //refresh
        notifyListeners();
        return true;
      } else {
        //show snackbar
        _snackbarService.showSnackbar(
            message:
                _waterTankMonitor.name + ' Deleting product has been failed.');
      }
    } else {
      return false;
    }
  }
}
