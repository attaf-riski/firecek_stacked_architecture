import 'package:firebase_database/firebase_database.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/firemonitor/firemonitor_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class FireMonitorTileView extends StatelessWidget {
  final String productKey;
  FireMonitorTileView({this.productKey});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FireMonitorTileViewModel>.reactive(
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
                    model.fireMonitor = snapshot.data.snapshot.value;
                    return Container(
                        child: Card(
                          child: ListTile(
                            title: Text(model.fireMonitor.productName),
                            trailing: SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10.0,
                                        backgroundColor:
                                            model.fireMonitor.fireMonitor1
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      Text(' Fault Checker')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10.0,
                                        backgroundColor:
                                            model.fireMonitor.fireMonitor2
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      Text(' Fire Checker')
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              width: 120,
                            ),
                            onTap: () async {
                              model.pushToDetail();
                            },
                          ),
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        ),
                        height: 90,
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
        viewModelBuilder: () => FireMonitorTileViewModel());
  }
}
