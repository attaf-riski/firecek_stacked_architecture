import 'package:firecek_stacked_architecture/app/router.gr.dart' as AR;
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workmanager/workmanager.dart';
import 'app/locator.dart';
import 'models/user.dart';
import 'models/user_data.dart';

//background meesage handler
Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  print("onMessage: $message");
  var _data = message['data'];
  var _title = _data['title'];
  var _content = _data['message'];
  var _productType = _data['product_type'];
  //must update
  PushNotificationService.showNotificationWithDefaultSound(_title, _content,
      productType: _productType);
  return Future<void>.value();
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

void callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RealtimeDBService _realtimeDBService = RealtimeDBService();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  Workmanager.executeTask((task, inputData) async {
    bool isUserLogin = await _authService.isUserLoggedIn();

    print(
        '(UPDATE) callbackDispatcher:executeTask tasdQk : $task || input data :$inputData || user login : $isUserLogin');
    //apabila login baru bisa menjalankan task
    if (isUserLogin) {
      User user = await _authService.userUIDAndEmail;
      UserData userData =
          await _firestoreService.userDataFuture(user.uid, user.email);
      if (task == UPDATEDBTASK) {
        //list string to list string
        var entryList = userData.myProduct;
        for (int i = 0; i < entryList.length; i++) {
          //listProduct['']
          //index 0 for list lalu ambil index dari productKeyandType list
          //productKeyandTypes is String
          var productKeyandTypes = entryList[i];
          //productKeyandType is list from productKeyandTypes
          //productKeyandType[0] = product key
          //productKeyandType[1] = product type
          var productKeyandType = productKeyandTypes.split('_');
          bool result;
          if (productKeyandType[1] == WATERTANKMONITORING) {
            /////////test
            //update db process
            result = await _realtimeDBService
                .updateWatertankAndPumpStatus(productKeyandType[0]);
            print('(UPDATE) executeTask:watertank productkey : ' +
                productKeyandType[0] +
                ' || result :$result');
          } else if (productKeyandType[1] == FIREMONITORING) {
            result = await _realtimeDBService
                .updateFireMonitor1And2(productKeyandType[0]);
            print('(UPDATE) executeTask:firemonitor productkey : ' +
                productKeyandType[0] +
                ' || result :$result');
          }
        }
      }
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      //home: FireMonitorDetailView(), //if want ot test view
      initialRoute: AR.Routes.wrapperViewRoute,
      onGenerateRoute: AR.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
