import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertankmonitor/watertank_monitoring_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WaterTankMonitoringTileViewModel extends StreamViewModel {
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
  String _productKey;
  set productKey(String productKey) {
    _productKey = productKey;
    notifyListeners();
  }

  //push to detail
  Future pushToDetail() async {
    await _navigationService.navigateWithTransition(
        WaterTankMonitoringDetailView(
          productKey: _productKey,
        ),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
  }

  @override
  Stream get stream =>
      _realtimeDBService.listenToWaterTankMonitorRealTime(_productKey);
}
