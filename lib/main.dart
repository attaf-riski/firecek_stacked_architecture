import 'package:firecek_stacked_architecture/app/router.gr.dart' as AR;
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';

void main(List<String> args) {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: AuthenticateView(), //if want ot test view
      initialRoute: AR.Routes.wrapperViewRoute,
      onGenerateRoute: AR.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
