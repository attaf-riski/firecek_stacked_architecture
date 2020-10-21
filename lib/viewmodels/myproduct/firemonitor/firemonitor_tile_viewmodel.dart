import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/firemonitor/firemonitor_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FireMonitorTileViewModel extends StreamViewModel {
  RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  NavigationService _navigationService = locator<NavigationService>();
  //data
  FireMonitor _fireMonitor;
  get fireMonitor => _fireMonitor;
  set fireMonitor(var dataJson) {
    _fireMonitor = FireMonitor.fromJson(map: dataJson);
  }

  //product key and its setter
  String _productKey = 'initialised';
  set productKey(String productKey) {
    _productKey = productKey;
    notifySourceChanged();
  }

  //push to detail
  Future pushToDetail() async {
    await _navigationService.navigateWithTransition(
        FireMonitorDetailView(
          productKey: _productKey,
        ),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
  }

  @override
  Stream get stream =>
      _realtimeDBService.listenToFireMonitorRealTime(_productKey);
}
