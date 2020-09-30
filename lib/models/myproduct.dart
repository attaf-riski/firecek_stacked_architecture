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
