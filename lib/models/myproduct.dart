class WaterTankMonitor {
  final bool diesel, electric, jockie, pump, waterTank;
  final int distance, fixDistance, limit, volume, volumeSet;
  final String status, name, macAddress, password;
  final history;

  WaterTankMonitor(
      {this.diesel,
      this.electric,
      this.jockie,
      this.pump,
      this.waterTank,
      this.distance,
      this.fixDistance,
      this.limit,
      this.volume,
      this.volumeSet,
      this.status,
      this.name,
      this.macAddress,
      this.history,
      this.password});

  static WaterTankMonitor fromJson({Map<dynamic, dynamic> json}) {
    return WaterTankMonitor(
        diesel: json['Diesel'],
        electric: json['Electric'],
        jockie: json['Jockie'],
        pump: json['Pump'],
        waterTank: json['WaterTank'],
        distance: json['Distance'],
        fixDistance: json['FixDistance'],
        limit: json['Limit'],
        volume: json['Volume'],
        volumeSet: json['VolumeSet'],
        status: json['Status'],
        name: json['Name'],
        macAddress: json['Mac Address'],
        history: json['History'] ?? [],
        password: json['Password']);
  }
}

class FireMonitor {
  final bool acFault,
      batteryFault,
      fireMonitor1,
      fireMonitor2,
      zone1,
      zone2,
      zone3,
      zone4,
      zone1Fault,
      zone2Fault,
      zone3Fault,
      zone4Fault;
  final history;
  final String productName, zone1Name, zone2Name, zone3Name, zone4Name;
  FireMonitor(
      {this.acFault,
      this.batteryFault,
      this.fireMonitor1,
      this.fireMonitor2,
      this.history,
      this.productName,
      this.zone1Name,
      this.zone2Name,
      this.zone3Name,
      this.zone4Name,
      this.zone1,
      this.zone2,
      this.zone3,
      this.zone4,
      this.zone1Fault,
      this.zone2Fault,
      this.zone3Fault,
      this.zone4Fault});

  static FireMonitor fromJson({Map<dynamic, dynamic> map}) {
    return FireMonitor(
      acFault: map['ACFault'],
      batteryFault: map['BatteryFault'],
      fireMonitor1: map['FireMonitor1'],
      fireMonitor2: map['FireMonitor2'],
      history: map['History'] ?? [],
      productName: map['ProductName'],
      zone1: map['Zone1'],
      zone2: map['Zone2'],
      zone3: map['Zone3'],
      zone4: map['Zone4'],
      zone1Fault: map['Zone1Fault'],
      zone2Fault: map['Zone2Fault'],
      zone3Fault: map['Zone3Fault'],
      zone4Fault: map['Zone4Fault'],
      zone1Name: map['Zone1Name'],
      zone2Name: map['Zone2Name'],
      zone3Name: map['Zone3Name'],
      zone4Name: map['Zone4Name'],
    );
  }
}
