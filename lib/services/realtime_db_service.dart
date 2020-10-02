import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDBService {
  DatabaseReference _myProductRef = FirebaseDatabase.instance.reference();

  Stream listenToWaterTankMonitorRealTime(String productkey) {
    return _myProductRef.child('WaterTank').onValue;
  }

  Future<bool> updateSettingsWaterTankMonitor(String productKey, String name,
      int fixDistance, int limit, int volumeSet) async {
    try {
      print(
          '(TRACE) RealtimeDBService:updateSettingsWaterTankMonitor. product key: $productKey');
      await _myProductRef.child('WaterTank').child(productKey).update({
        'Name': '$name',
        'FixDistance': fixDistance,
        'Limit': limit,
        'VolumeSet': volumeSet
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
