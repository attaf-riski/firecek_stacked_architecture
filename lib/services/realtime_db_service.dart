import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDBService {
  DatabaseReference _myProductRef = FirebaseDatabase.instance.reference();

  //watertank
  Stream listenToWaterTankMonitorRealTime(String productkey) async* {
    yield _myProductRef.child('WaterTank').onValue;
  }

  //watertank
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

  //check for is the product exist or not
  //multi product
  Future isProductExist(String productType, String productKey) async {
    var result = await _myProductRef
        .child(productType)
        .child(productKey)
        .once()
        .then((value) {
      if (value.value != null) {
        print(value.value);
        print(
            '(TRACE)[FOUND 1] RealtimeDBService:isProductExist. product type: $productType product key : $productKey');
        return true;
      } else {
        print(
            '(TRACE)[NOT FOUND 1] RealtimeDBService:isProductExist. product type: $productType product key : $productKey');
        return false;
      }
    });
    if (result == true) {
      print(
          '(TRACE)[FOUND 2] RealtimeDBService:isProductExist. product type: $productType product key : $productKey');
      return true;
    } else {
      print(
          '(TRACE)[NOT FOUND 2] RealtimeDBService:isProductExist. product type: $productType product key : $productKey');
      return false;
    }
  }

  //check mac adress
  //multi product
  Future<String> getMacAddress(String productType, String productKey) async {
    String result = (await _myProductRef
            .child(productType)
            .child(productKey)
            .child('Mac Address')
            .once())
        .value;
    print(
        '(TRACE) RealtimeDBService:getMacAddress. product type: $productType product key : $productKey result: $result');
    return result;
  }

  //watertank
  //update watertank and pump status to false every 10 minutes
  Future<bool> updateWatertankAndPumpStatus(String productKey) async {
    bool result = true;
    await _myProductRef.child('WaterTank').child(productKey).update({
      'WaterTank': false,
      'Pump': false,
    }).catchError((e) => result = false);
    return result;
  }
}
