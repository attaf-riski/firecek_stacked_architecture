import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertankmonitor/menu_watertankmonitor_detail_view.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background_watertankmonitor_detail.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/watertankmonitor_bar.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertankmonitor/watertank_monitoring_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WaterTankMonitoringDetailView extends StatelessWidget {
  final String productKey;
  WaterTankMonitoringDetailView({this.productKey});
  @override
  Widget build(BuildContext context) {
    double ratio;
    final double topHeight = MediaQuery.of(context).size.height * 0.22;
    final double bottomheight = MediaQuery.of(context).size.height * 0.75;
    Color waterColor;
    Color waterColorOppacity;
    return ViewModelBuilder<WatertankMonitoringDetailViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: StreamBuilder(
                  stream: model.data,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      model.waterTankMonitor = snapshot.data.snapshot.value;
                      ///////////var place//////////////
                      //ratio
                      ratio = (model.waterTankMonitor.distance /
                          model.waterTankMonitor.fixDistance);
                      //water color
                      if (ratio > 0.7) {
                        waterColor = Colors.blue;
                      } else if (ratio > 0.3) {
                        waterColor = Colors.amber;
                      } else {
                        waterColor = Colors.red;
                      }
                      //water color oppacity
                      if (ratio > 0.7) {
                        waterColorOppacity = Colors.blue[100];
                      } else if (ratio > 0.3) {
                        waterColorOppacity = Colors.amber[100];
                      } else {
                        waterColorOppacity = Colors.red[100];
                      }
                      ///////////var place//////////////
                      return ListView(
                        children: [
                          SizedBox(
                              child: TopBackGroundWaterTankMonitorDetail(
                                waterTankMonitorStatus:
                                    model.waterTankMonitor.waterTank,
                                backButton: model.backButton,
                              ),
                              height: topHeight),
                          SizedBox(
                            child: Row(children: [
                              WaterTankMonitorBar(
                                height: bottomheight,
                                waterColor: waterColor,
                                waterColorOppacity: waterColorOppacity,
                                ratio: ratio,
                              ),
                              MenuWaterTankMonitorDetailView(
                                productKey: model.productKey,
                                waterTankMonitor: model.waterTankMonitor,
                              )
                            ]),
                            height: bottomheight,
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      );
                    } else {
                      return Loading();
                    }
                  }),
            ),
        onModelReady: (model) => model.productKey = productKey,
        viewModelBuilder: () => WatertankMonitoringDetailViewModel());
  }
}
