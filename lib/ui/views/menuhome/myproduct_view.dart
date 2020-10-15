import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertankmonitor/watertank_monitoring_tile_view.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/myproduct_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class MyProductView extends StatelessWidget {
  //refresh controller
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyProductViewModel>.reactive(
        builder: (context, model, child) => (model.isBusy)
            ? Loading()
            : (model.userData.myProduct.isEmpty)
                ? LottieMessage(
                    lottiePath: 'assets/lottie/empty.json',
                    title: "You haven't added product.")
                : Container(
                    child: Padding(
                      child: SmartRefresher(
                        controller: _refreshController,
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: model.userData.myProduct.length,
                            itemBuilder: (context, index) {
                              //multiproduct start here
                              //index 0 = productKey
                              //index 1 = productType
                              List productKeyAndProductType =
                                  model.userData.myProduct[index].split('_');
                              if (productKeyAndProductType[1] == 'WaterTank') {
                                //error muncul disini
                                return WaterTankMonitoringTile(
                                    productKey: productKeyAndProductType[0]);
                              } else {
                                return SizedBox();
                              }
                            }),
                        enablePullDown: true,
                        onRefresh: () async {
                          model.notifyListeners();
                          await Future.delayed(Duration(seconds: 1));
                          _refreshController.refreshCompleted();
                        },
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
        onModelReady: (model) async {
          await model.listenToUserData();
        },
        viewModelBuilder: () => MyProductViewModel());
  }
}
