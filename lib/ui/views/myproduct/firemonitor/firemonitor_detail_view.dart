import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/widgets/firemonitor/fm_body_detail.dart';
import 'package:firecek_stacked_architecture/ui/widgets/firemonitor/fm_header_detail.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/firemonitor/firemonitor_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FireMonitorDetailView extends StatelessWidget {
  final String productKey;
  FireMonitorDetailView({this.productKey});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FireMonitorDetailViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: StreamBuilder(
                stream: model.data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    model.fireMonitor = snapshot.data.snapshot.value;

                    return Container(
                      child: ListView(children: [
                        //header
                        SizedBox(
                          child: FMHeaderDetail(
                              initialData: model.productName,
                              onTap: model.backButton,
                              onSubmitted: model.updateProductName),
                          height: MediaQuery.of(context).size.height * 0.23,
                        ),
                        //body
                        SizedBox(
                          child: FMBodyDetail(
                            deleteProduct: model.deleteProduct,
                            fireMonitor: model.fireMonitor,
                            history: model.pushToHistory,
                            isNotificatationEnable: model.isNotificationEnabled,
                            onOffNotif:
                                model.toggleEnableAndDisableNotification,
                            zoneNameChanged: model.updateZone,
                          ),
                          height: MediaQuery.of(context).size.height * 0.77,
                        ),
                      ]),
                      height: MediaQuery.of(context).size.height,
                    );
                  } else {
                    return Loading();
                  }
                },
              ),
            ),
        onModelReady: (model) {
          model.productKey = productKey;
          model.readLocalStorage();
        },
        viewModelBuilder: () => FireMonitorDetailViewModel());
  }
}
