import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firecek_stacked_architecture/shared/enums.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class ConnectivityService with ReactiveServiceMixin {
  //reactive, it is for detect if there exist a change
  RxValue<bool> _isOffline = RxValue<bool>(initial: false);

  bool get isOffline => _isOffline.value;

  void setOffline(bool isOffline) {
    _isOffline.value = isOffline;
  }

  // Create our public controller
  static StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  //get  stream controller
  Stream stream = connectionStatusController.stream;

  ConnectivityService() {
    listenToReactiveValues([_isOffline]);
    // Subscribe to the connectivity Changed Stream
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need it
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    print('(TRACE) ConnectivityService:_getStatusFromResult. result : $result');
    switch (result) {
      case ConnectivityResult.mobile:
        setOffline(false);
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        setOffline(false);
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        setOffline(true);
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
