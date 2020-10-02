import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertankmonitor/watertank_monitoring_tile_view.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/menu_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuHomeViewModel>.reactive(
        builder: (context, model, child) => (model.isBusy)
            ? Loading()
            : Container(
                child: Padding(
                  child: ListView.builder(
                      itemCount: model.userData.myProduct.length,
                      itemBuilder: (context, index) {
                        //multiproduct start here
                        //index 0 = productKey
                        //index 1 = productType
                        List productKeyAndProductType =
                            model.userData.myProduct[index].split('_');
                        if (productKeyAndProductType[1] == 'WaterTank') {
                          return WaterTankMonitoringTile(
                              productKey: productKeyAndProductType[0]);
                        } else {
                          return SizedBox();
                        }
                      }),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        onModelReady: (model) => model.listenToUserData(),
        viewModelBuilder: () => locator<MenuHomeViewModel>());
  }
}
