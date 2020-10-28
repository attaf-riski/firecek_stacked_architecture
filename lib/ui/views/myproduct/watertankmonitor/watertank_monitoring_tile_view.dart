import 'package:firebase_database/firebase_database.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
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
                    model.waterTankMonitor = snapshot.data.snapshot.value;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/products/WaterTank.png'),
                                      fit: BoxFit.fill),
                                  flex: 1,
                                ),
                                horizontalSpaceSmall,
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 10.0,
                                                backgroundColor: model
                                                            .waterTankMonitor
                                                            .status ==
                                                        'Normal'
                                                    ? Colors.green
                                                    : Colors.red),
                                            Text(' Status')
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10.0,
                                              backgroundColor: model
                                                      .waterTankMonitor
                                                      .waterTank
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
                                          MainAxisAlignment.spaceAround,
                                    ),
                                    color: Color(0xeeeeee),
                                  ),
                                  flex: 1,
                                )
                              ],
                            ),
                            height: 110,
                            width: double.infinity,
                          ),
                          Container(
                            child: Column(
                              children: [
                                verticalSpaceTiny,
                                Text(
                                  model.waterTankMonitor.name,
                                  style: textStyleJudul.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  model.waterTankMonitor.status,
                                  style: textStyleJudul,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            height: 50,
                            width: double.infinity,
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      height: 220,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    );
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

// child: ListTile(
//                             leading: CircleAvatar(
//                                 radius: 25.0,
//                                 backgroundColor:
//                                     (model.waterTankMonitor.status == 'Normal')
//                                         ? Colors.green
//                                         : Colors.red),
//                             subtitle: Text(model.waterTankMonitor.status),
//                             title: Text(model.waterTankMonitor.name),
//                             trailing: SizedBox(
//                               child: Column(
//                                 children: [
//
//                                 ],
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                               ),
//                               width: 120,
//                             ),
//                             onTap: () async {
//                               model.pushToDetail();
//                             },
//                           ),
