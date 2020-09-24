// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firecek_stacked_architecture/ui/views/wrapper_view.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/authenticate_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/home_view.dart';

abstract class Routes {
  static const wrapperViewRoute = '/';
  static const authenticateViewRoute = '/authenticate-view-route';
  static const homeViewRoute = '/home-view-route';
  static const all = {
    wrapperViewRoute,
    authenticateViewRoute,
    homeViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.wrapperViewRoute:
        if (hasInvalidArgs<WrapperViewArguments>(args)) {
          return misTypedArgsRoute<WrapperViewArguments>(args);
        }
        final typedArgs =
            args as WrapperViewArguments ?? WrapperViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => WrapperView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.authenticateViewRoute:
        if (hasInvalidArgs<AuthenticateViewArguments>(args)) {
          return misTypedArgsRoute<AuthenticateViewArguments>(args);
        }
        final typedArgs =
            args as AuthenticateViewArguments ?? AuthenticateViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AuthenticateView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homeViewRoute:
        if (hasInvalidArgs<HomeViewArguments>(args)) {
          return misTypedArgsRoute<HomeViewArguments>(args);
        }
        final typedArgs = args as HomeViewArguments ?? HomeViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//WrapperView arguments holder class
class WrapperViewArguments {
  final Key key;
  WrapperViewArguments({this.key});
}

//AuthenticateView arguments holder class
class AuthenticateViewArguments {
  final Key key;
  AuthenticateViewArguments({this.key});
}

//HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  HomeViewArguments({this.key});
}
