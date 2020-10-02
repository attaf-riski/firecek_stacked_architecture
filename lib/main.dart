import 'package:firecek_stacked_architecture/app/router.gr.dart' as AR;
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'ui/views/myproduct/watertankmonitor/settings_watertankmonitor_detail_view.dart';

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
        //home: SettingsWaterTankMonitorView(), //if want ot test view
        initialRoute: AR.Routes.wrapperViewRoute,
        onGenerateRoute: AR.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
