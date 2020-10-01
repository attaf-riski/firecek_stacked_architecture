import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/item_menu_myproduct_detail.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/menu_myproduct_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class MenuMyProductDetailView extends StatelessWidget {
  final WaterTankMonitor waterTankMonitor;
  MenuMyProductDetailView({this.waterTankMonitor});
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
    return ViewModelBuilder<MenuMyProductDetailViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: ListView(
          children: [
            ItemMenuMyProductdetail(
              title: 'Status',
              fontColor: Colors.white,
              content: [status],
              isNeedBackground: true,
              isPumpOrStatusOn: [statusCondition],
            ),
            ItemMenuMyProductdetail(
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
            ItemMenuMyProductdetail(
              title: 'Surface Height',
              content: [waterTankMonitor.distance.toString() + ' CM'],
            ),
            ItemMenuMyProductdetail(
              title: 'Water Percentage',
              content: [(ratio * 100).toStringAsFixed(0) + ' %'],
            ),
            ItemMenuMyProductdetail(
              title: 'Volume',
              content: [(volume.format(waterTankMonitor.volume / 100)) + ' M3'],
            ),
            verticalSpaceTiny,
            Material(
              color: Color(0xffe4f2fd),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ItemMenuMyProductdetail(
                  cardColor: Colors.transparent,
                  content: ['Settings'],
                ),
                splashColor: Color(0xffbbdefa),
                onTap: () async {
                  await model.pushToSetting();
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            verticalSpaceTiny,
            Material(
              color: Color(0xffe4f2fd),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ItemMenuMyProductdetail(
                  cardColor: Colors.transparent,
                  content: ['History'],
                ),
                splashColor: Color(0xffbbdefa),
                onTap: () {},
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            verticalSpaceTiny,
            Material(
              color: Color(0xffe4f2fd),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ItemMenuMyProductdetail(
                  fontSize: 12,
                  cardColor: Colors.transparent,
                  content: ['Enable Notification'],
                ),
                splashColor: Color(0xffbbdefa),
                onTap: () {},
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            verticalSpaceTiny,
            Material(
              color: Colors.red,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: ItemMenuMyProductdetail(
                  fontColor: Colors.white,
                  content: ['Delete Product'],
                  cardColor: Colors.transparent,
                ),
                splashColor: Color(0xffbbdefa),
                onTap: () {},
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 30.0),
      ),
      viewModelBuilder: () => MenuMyProductDetailViewModel(),
      onModelReady: (model) => model.waterTankMonitor = waterTankMonitor,
    );
  }
}