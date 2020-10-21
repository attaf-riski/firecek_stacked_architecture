import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WatertankMonitoringDetailViewModel extends StreamViewModel {
  final RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  final NavigationService _navigationService = locator<NavigationService>();
  //watertankmonitoring data
  WaterTankMonitor _waterTankMonitor;
  //getter
  WaterTankMonitor get waterTankMonitor => _waterTankMonitor;
  //setter
  //for mapping json/map to custom class
  set waterTankMonitor(var dataJson) {
    _waterTankMonitor = WaterTankMonitor.fromJson(json: dataJson);
  }

  //product key and its setter
  String _productKey = 'initialised';
  get productKey => _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifySourceChanged();
  }

  //backbutton
  void backButton() {
    _navigationService.back();
  }

  @override
  Stream get stream =>
      _realtimeDBService.listenToWaterTankMonitorRealTime(_productKey);
}
