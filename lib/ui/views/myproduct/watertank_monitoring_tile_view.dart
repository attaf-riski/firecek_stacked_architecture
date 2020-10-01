import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertank_monitoring_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WaterTankMonitoringTile extends StatelessWidget {
  final String productKey;
  WaterTankMonitoringTile({this.productKey});

  @override
  Widget build(BuildContext context) {
    print(productKey);
    return ViewModelBuilder<WaterTankMonitoringTileViewModel>.reactive(
        builder: (context, model, child) => StreamBuilder(
            stream: model.waterTankMonitorStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var _waterTankMonitorPath = snapshot.data;
                model.waterTankMonitor =
                    _waterTankMonitorPath.snapshot.value[productKey];
                return Padding(
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
                                    backgroundColor: model.waterTankMonitor.pump
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  Text(' Pump')
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: 100,
                        ),
                        onTap: () async {
                          model.pushToDetail();
                        },
                      ),
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    ),
                    padding: EdgeInsets.only(top: 8.0));
              } else {
                return Loading();
              }
            }),
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        onModelReady: (model) => model.productKey = productKey,
        viewModelBuilder: () => WaterTankMonitoringTileViewModel());
  }
}
