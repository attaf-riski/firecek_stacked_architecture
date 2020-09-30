import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:stacked/stacked.dart';

class WaterTankMonitoringTileViewModel extends BaseViewModel {
  final RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  //watertankmonitoring data
  WaterTankMonitor _waterTankMonitor;
  //getter
  WaterTankMonitor get waterTankMonitor => _waterTankMonitor;
  //setter
  //for mapping json/map to custom class
  set waterTankMonitor(var dataJson) {
    _waterTankMonitor = WaterTankMonitor.fromJson(json: dataJson);
    notifyListeners();
  }

  //product key and its setter
  String _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifyListeners();
  }

  //stream
  Stream get waterTankMonitorStream =>
      _realtimeDBService.listenToWaterTankMonitorRealTime(_productKey);
}
