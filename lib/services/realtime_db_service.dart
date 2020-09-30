import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDBService {
  DatabaseReference _myProductRef = FirebaseDatabase.instance.reference();

  Stream listenToWaterTankMonitorRealTime(String productkey) {
    return _myProductRef.child('WaterTank').onValue;
  }
}
