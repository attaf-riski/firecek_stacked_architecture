import 'package:firecek_stacked_architecture/app/router.gr.dart' as AR;
import 'package:firecek_stacked_architecture/ui/views/myproduct/watertank_monitoring_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        //home: WaterTankMonitoringDetailView(), //if want ot test view
        initialRoute: AR.Routes.wrapperViewRoute,
        onGenerateRoute: AR.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
