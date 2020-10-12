import 'package:firebase_database/firebase_database.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertankmonitor/watertank_monitoring_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class WaterTankMonitoringTile extends StatelessWidget {
  final String productKey;
  WaterTankMonitoringTile({this.productKey});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WaterTankMonitoringTileViewModel>.reactive(
        builder: (context, model, child) => (!model.dataReady &&
                !model.hasError)
            ? Padding(
                child: Card(
                  child: LottieBuilder.asset('assets/lottie/list-loader.json'),
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                ),
                padding: EdgeInsets.only(top: 8.0))
            : StreamBuilder<Event>(
                stream: model.data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var _waterTankMonitorPath = snapshot.data;
                    model.waterTankMonitor =
                        _waterTankMonitorPath.snapshot.value[productKey];
                    return Container(
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 25.0,
                                backgroundColor:
                                    (model.waterTankMonitor.status == 'Normal')
                                        ? Colors.green
                                        : Colors.red),
                            subtitle: Text(model.waterTankMonitor.status),
                            title: Text(model.waterTankMonitor.name),
                            trailing: SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10.0,
                                        backgroundColor:
                                            model.waterTankMonitor.waterTank
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      Text(' WaterTank')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10.0,
                                        backgroundColor:
                                            model.waterTankMonitor.pump
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      Text(' Pump')
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              width: 100,
                            ),
                            onTap: () async {
                              model.pushToDetail();
                            },
                          ),
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        ),
                        margin: EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(top: 8.0));
                  } else {
                    return Padding(
                        child: Card(
                          child: LottieBuilder.asset(
                              'assets/lottie/list-loader.json'),
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        ),
                        padding: EdgeInsets.only(top: 8.0));
                  }
                }),
        onModelReady: (model) {
          model.productKey = productKey;
        },
        viewModelBuilder: () => WaterTankMonitoringTileViewModel());
  }
}
