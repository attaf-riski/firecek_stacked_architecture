import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/firemonitor/zone_tile.dart';
import 'package:firecek_stacked_architecture/ui/widgets/material_inkwell.dart';
import 'package:flutter/material.dart';

class FMBodyDetail extends StatelessWidget {
  final FireMonitor fireMonitor;
  final FocusNode zone1NameFocusNode = FocusNode();
  final FocusNode zone2NameFocusNode = FocusNode();
  final FocusNode zone3NameFocusNode = FocusNode();
  final FocusNode zone4NameFocusNode = FocusNode();
  final Function zoneNameChanged;
  final bool isNotificatationEnable;
  final Function deleteProduct, onOffNotif, history;
  final double addTextSize;
  FMBodyDetail({
    this.addTextSize = 0,
    this.history,
    this.onOffNotif,
    this.isNotificatationEnable,
    this.deleteProduct,
    this.fireMonitor,
    this.zoneNameChanged,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      addSemanticIndexes: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //zone
              SizedBox(
                child: Column(
                  children: [
                    verticalSpaceTiny,
                    //2 zone
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: ZoneTile(
                                  addTextSize: addTextSize,
                                  focusNode: zone1NameFocusNode,
                                  isWhiteColor: (fireMonitor.zone1 ||
                                          fireMonitor.zone1Fault)
                                      ? true
                                      : false,
                                  isZone: true,
                                  imagePath: (fireMonitor.zone1Fault)
                                      ? (fireMonitor.zone1)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/fault.png'
                                      : (fireMonitor.zone1)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/normal.png',
                                  onSubmitted: zoneNameChanged,
                                  title: 'Zone 1',
                                  subtitle: fireMonitor.zone1Name,
                                  zoneKey: 'Zone1Name',
                                )),
                            horizontalSpaceSmall,
                            Flexible(
                                flex: 1,
                                child: ZoneTile(
                                  addTextSize: addTextSize,
                                  focusNode: zone2NameFocusNode,
                                  isWhiteColor: (fireMonitor.zone2 ||
                                          fireMonitor.zone2Fault)
                                      ? true
                                      : false,
                                  isZone: true,
                                  imagePath: (fireMonitor.zone2Fault)
                                      ? (fireMonitor.zone2)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/fault.png'
                                      : (fireMonitor.zone2)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/normal.png',
                                  onSubmitted: zoneNameChanged,
                                  title: 'Zone 2',
                                  subtitle: fireMonitor.zone2Name,
                                  zoneKey: 'Zone2Name',
                                )),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    //2 zone
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: ZoneTile(
                                  addTextSize: addTextSize,
                                  focusNode: zone3NameFocusNode,
                                  isWhiteColor: (fireMonitor.zone3 ||
                                          fireMonitor.zone3Fault)
                                      ? true
                                      : false,
                                  isZone: true,
                                  imagePath: (fireMonitor.zone3Fault)
                                      ? (fireMonitor.zone3)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/fault.png'
                                      : (fireMonitor.zone3)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/normal.png',
                                  onSubmitted: zoneNameChanged,
                                  title: 'Zone 3',
                                  subtitle: fireMonitor.zone3Name,
                                  zoneKey: 'Zone3Name',
                                )),
                            horizontalSpaceSmall,
                            Flexible(
                                flex: 1,
                                child: ZoneTile(
                                  addTextSize: addTextSize,
                                  focusNode: zone4NameFocusNode,
                                  isWhiteColor: (fireMonitor.zone4 ||
                                          fireMonitor.zone4Fault)
                                      ? true
                                      : false,
                                  isZone: true,
                                  imagePath: (fireMonitor.zone4Fault)
                                      ? (fireMonitor.zone4)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/fault.png'
                                      : (fireMonitor.zone4)
                                          ? 'assets/images/firemonitorAssets/Fire.png'
                                          : 'assets/images/firemonitorAssets/normal.png',
                                  onSubmitted: zoneNameChanged,
                                  title: 'Zone 4',
                                  subtitle: fireMonitor.zone4Name,
                                  zoneKey: 'Zone4Name',
                                )),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      ),
                    ),
                    verticalSpaceTiny,
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                height: MediaQuery.of(context).size.height * 0.25,
              ),

              //battery health and AC
              SizedBox(
                child: Column(
                  children: [
                    verticalSpaceTiny,
                    Flexible(
                      flex: 1,
                      child: ZoneTile(
                        addTextSize: addTextSize,
                        color: (fireMonitor.batteryFault)
                            ? Colors.red
                            : Colors.lightBlue,
                        isWhiteColor: true,
                        imagePath: (fireMonitor.batteryFault)
                            ? 'assets/images/firemonitorAssets/bat_fault.png'
                            : 'assets/images/firemonitorAssets/bat_normal.png',
                        title: 'BATTERY HEALTH',
                        subtitle: (fireMonitor.batteryFault)
                            ? 'Battery Damage!'
                            : 'Normal',
                      ),
                    ),
                    verticalSpaceSmall,
                    Flexible(
                      flex: 1,
                      child: ZoneTile(
                        addTextSize: addTextSize,
                        color: (fireMonitor.acFault)
                            ? Colors.red
                            : Colors.lightBlue,
                        isWhiteColor: true,
                        imagePath: (fireMonitor.acFault)
                            ? 'assets/images/firemonitorAssets/ac_fault.png'
                            : 'assets/images/firemonitorAssets/ac_normal.png',
                        title: 'AC CURRENT',
                        subtitle:
                            (fireMonitor.acFault) ? 'AC Fault!' : 'Normal',
                      ),
                    ),
                    verticalSpaceSmall,
                    Flexible(
                      flex: 1,
                      child: MaterialInkwell(
                        borderRadiusValue: 15,
                        backgroundColor:
                            isNotificatationEnable ? Colors.red : Colors.green,
                        child: ZoneTile(
                          addTextSize: addTextSize,
                          title: 'HISTORY',
                          subtitle: '',
                        ),
                        onTap: () => history(),
                        splashColor: Color(0xffbbdefa),
                      ),
                    ),
                    verticalSpaceSmall,
                    Flexible(
                      flex: 1,
                      child: MaterialInkwell(
                        borderRadiusValue: 15,
                        backgroundColor:
                            isNotificatationEnable ? Colors.red : Colors.green,
                        child: ZoneTile(
                            addTextSize: addTextSize,
                            color: Colors.transparent,
                            isWhiteColor: true,
                            title: isNotificatationEnable
                                ? 'DISABLE NOTIFICATION'
                                : 'ENABLE NOTIFICATION',
                            subtitle: ''),
                        onTap: () => onOffNotif(),
                        splashColor: Color(0xffbbdefa),
                      ),
                    ),
                    verticalSpaceSmall,
                    Flexible(
                      flex: 1,
                      child: MaterialInkwell(
                        borderRadiusValue: 15,
                        backgroundColor: Colors.red,
                        child: ZoneTile(
                          addTextSize: addTextSize,
                          color: Colors.transparent,
                          isWhiteColor: true,
                          title: 'DELETE PRODUCT',
                          subtitle: '',
                        ),
                        onTap: () => deleteProduct(),
                        splashColor: Color(0xffbbdefa),
                      ),
                    ),
                    verticalSpaceSmall,
                    verticalSpaceSmall,
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                height: MediaQuery.of(context).size.height * 0.68,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
