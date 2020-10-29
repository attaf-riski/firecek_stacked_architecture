import 'package:firebase_database/firebase_database.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/firemonitor/firemonitor_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FireMonitorTileView extends StatelessWidget {
  final String productKey;
  FireMonitorTileView({this.productKey});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FireMonitorTileViewModel>.reactive(
        builder: (context, model, child) => (!model.dataReady && model.hasError)
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        spreadRadius: 3,
                        offset: Offset.fromDirection(1, 1))
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                          height: 110,
                          width: double.infinity,
                        ),
                        flex: 1,
                      ),
                      horizontalSpaceSmall,
                      VerticalDivider(
                        color: Colors.grey,
                        width: 2,
                        thickness: 2,
                      ),
                      horizontalSpaceSmall,
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  verticalSpaceTiny,
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: 20,
                                    width: double.infinity,
                                  ),
                                  verticalSpaceTiny,
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.grey),
                                      Text(' Fault Checker',
                                          style: TextStyle(fontSize: 10))
                                    ],
                                  ),
                                  horizontalSpaceSmall,
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.grey),
                                      Text(' Fire Checker',
                                          style: TextStyle(fontSize: 10))
                                    ],
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          color: Color(0xeeeeee),
                        ),
                        flex: 2,
                      )
                    ],
                  ),
                  height: 110,
                  width: double.infinity,
                ),
                height: 130,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              )
            : StreamBuilder<Event>(
                stream: model.data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    model.fireMonitor = snapshot.data.snapshot.value;
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                spreadRadius: 3,
                                offset: Offset.fromDirection(1, 1))
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/products/FireMonitor.png'),
                                    fit: BoxFit.fill),
                                flex: 1,
                              ),
                              horizontalSpaceSmall,
                              VerticalDivider(
                                color: Colors.grey,
                                width: 2,
                                thickness: 2,
                              ),
                              horizontalSpaceSmall,
                              Flexible(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          verticalSpaceTiny,
                                          Text(
                                            model.fireMonitor.productName,
                                            style: textStyleJudul.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 10.0,
                                                backgroundColor: model
                                                        .fireMonitor
                                                        .fireMonitor1
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              Text(' Fault Checker',
                                                  style:
                                                      TextStyle(fontSize: 10))
                                            ],
                                          ),
                                          horizontalSpaceSmall,
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 10.0,
                                                backgroundColor: model
                                                        .fireMonitor
                                                        .fireMonitor2
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              Text(' Fire Checker',
                                                  style:
                                                      TextStyle(fontSize: 10))
                                            ],
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                  color: Color(0xeeeeee),
                                ),
                                flex: 2,
                              )
                            ],
                          ),
                          height: 110,
                          width: double.infinity,
                        ),
                        height: 130,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      onTap: () async {
                        model.pushToDetail();
                      },
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              spreadRadius: 3,
                              offset: Offset.fromDirection(1, 1))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 110,
                                width: double.infinity,
                              ),
                              flex: 1,
                            ),
                            horizontalSpaceSmall,
                            VerticalDivider(
                              color: Colors.grey,
                              width: 2,
                              thickness: 2,
                            ),
                            horizontalSpaceSmall,
                            Flexible(
                              child: Container(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        verticalSpaceTiny,
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        verticalSpaceTiny,
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                                radius: 10.0,
                                                backgroundColor: Colors.grey),
                                            Text(' Fault Checker',
                                                style: TextStyle(fontSize: 10))
                                          ],
                                        ),
                                        horizontalSpaceSmall,
                                        Column(
                                          children: [
                                            CircleAvatar(
                                                radius: 10.0,
                                                backgroundColor: Colors.grey),
                                            Text(' Fire Checker',
                                                style: TextStyle(fontSize: 10))
                                          ],
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                color: Color(0xeeeeee),
                              ),
                              flex: 2,
                            )
                          ],
                        ),
                        height: 110,
                        width: double.infinity,
                      ),
                      height: 130,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    );
                  }
                }),
        onModelReady: (model) {
          model.productKey = productKey;
        },
        viewModelBuilder: () => FireMonitorTileViewModel());
  }
}
