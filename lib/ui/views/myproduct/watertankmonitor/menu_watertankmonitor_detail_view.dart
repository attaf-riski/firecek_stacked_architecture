import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/material_inkwell.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/item_menu_watertankmonitor_detail.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertankmonitor/menu_watertankmonitor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class MenuWaterTankMonitorDetailView extends StatelessWidget {
  final String productKey;
  final WaterTankMonitor waterTankMonitor;
  MenuWaterTankMonitorDetailView({this.productKey, this.waterTankMonitor});
  @override
  Widget build(BuildContext context) {
    ///////////for status//////////////
    String status;
    bool statusCondition;
    if (waterTankMonitor.status == 'Water Low') {
      status = 'WATER LOW';
      statusCondition = true;
    } else if (waterTankMonitor.status == 'SENSOR READ ERROR!') {
      status = 'SENSOR ERROR';
      statusCondition = true;
    } else if (waterTankMonitor.status == 'Normal') {
      status = 'NORMAL';
      statusCondition = false;
    } else {
      status = 'ERROR';
      statusCondition = true;
    }
    //ration
    double ratio = (waterTankMonitor.distance / waterTankMonitor.fixDistance);
    //for format number
    //for formating number so the number have dot every 3 digit
    var volume =
        NumberFormat.currency(locale: "en_US", symbol: "", decimalDigits: 0);
    ///////////for status//////////////
    ///////////boolean to string////////
    String dieselStatus =
        (waterTankMonitor.diesel) ? 'DIESEL ON' : 'DIESEL OFF';
    String electricStatus =
        (waterTankMonitor.electric) ? 'ELECTRIC ON' : 'ELECTRIC OFF';
    String jockeyStatus =
        (waterTankMonitor.jockie) ? 'JOCKEY ON' : 'JOCKEY OFF';
    ///////////boolean to string////////
    return ViewModelBuilder<MenuWaterTankMonitorViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: ListView(
          children: [
            ItemWaterTankMonitordetail(
              addTextSize: model.addTextSize,
              title: 'Status',
              fontColor: Colors.white,
              content: [status],
              isNeedBackground: true,
              isPumpOrStatusOn: [statusCondition],
            ),
            ItemWaterTankMonitordetail(
              addTextSize: model.addTextSize,
              title: 'Pump Status',
              fontColor: Colors.white,
              cardHeight: 175.0,
              content: [jockeyStatus, dieselStatus, electricStatus],
              isNeedBackground: true,
              isPumpOrStatusOn: [
                waterTankMonitor.jockie,
                waterTankMonitor.diesel,
                waterTankMonitor.electric
              ],
            ),
            ItemWaterTankMonitordetail(
              addTextSize: model.addTextSize,
              title: 'Surface Height',
              content: [waterTankMonitor.distance.toString() + ' CM'],
            ),
            ItemWaterTankMonitordetail(
              addTextSize: model.addTextSize,
              title: 'Water Percentage',
              content: [(ratio * 100).toStringAsFixed(0) + ' %'],
            ),
            ItemWaterTankMonitordetail(
              addTextSize: model.addTextSize,
              title: 'Volume',
              content: [(volume.format(waterTankMonitor.volume / 100)) + ' M3'],
            ),
            verticalSpaceTiny,
            MaterialInkwell(
              backgroundColor: Color(0xffe4f2fd),
              borderRadiusValue: 15,
              child: ItemWaterTankMonitordetail(
                addTextSize: model.addTextSize,
                cardColor: Colors.transparent,
                content: ['Settings'],
              ),
              onTap: () async => await model.pushToSetting(),
              splashColor: Color(0xffbbdefa),
            ),
            verticalSpaceTiny,
            MaterialInkwell(
              backgroundColor: Color(0xffe4f2fd),
              borderRadiusValue: 15,
              child: ItemWaterTankMonitordetail(
                addTextSize: model.addTextSize,
                cardColor: Colors.transparent,
                content: ['History'],
              ),
              onTap: () async => await model.pushToHistory(),
              splashColor: Color(0xffbbdefa),
            ),
            verticalSpaceTiny,
            MaterialInkwell(
              backgroundColor:
                  (model.isNotificationEnabled) ? Colors.red : Colors.green,
              borderRadiusValue: 15,
              child: ItemWaterTankMonitordetail(
                addTextSize: model.addTextSize,
                fontColor:
                    (model.isNotificationEnabled) ? Colors.white : Colors.black,
                fontSize: 12,
                cardColor: Colors.transparent,
                content: [
                  (model.isNotificationEnabled)
                      ? 'Disable Notification'
                      : 'Enable Notification'
                ],
              ),
              onTap: () async =>
                  await model.toggleEnableAndDisableNotification(),
              splashColor: Color(0xffbbdefa),
            ),
            verticalSpaceTiny,
            MaterialInkwell(
              backgroundColor: Colors.red,
              borderRadiusValue: 15,
              child: ItemWaterTankMonitordetail(
                addTextSize: model.addTextSize,
                fontColor: Colors.white,
                content: ['Delete Product'],
                cardColor: Colors.transparent,
              ),
              onTap: () async => await model.deleteProduct(),
              splashColor: Color(0xffbbdefa),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 30.0),
      ),
      viewModelBuilder: () => MenuWaterTankMonitorViewModel(),
      onModelReady: (model) async {
        model.loadAddTextSize();
        model.productKey = productKey;
        model.waterTankMonitor = waterTankMonitor;
        model.readLocalStorage();
      },
    );
  }
}
