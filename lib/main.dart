import 'package:firecek_stacked_architecture/app/router.gr.dart' as AR;
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/authenticate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workmanager/workmanager.dart';
import 'app/locator.dart';
import 'models/user.dart';
import 'models/user_data.dart';

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
        '(UPDATE) callbackDispatcher:executeTask task : $task || input data :$inputData || user login : $isUserLogin');
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
          if (productKeyandType[1] == WATERTANKMONITORING) {
            //update db process
            bool result = await _realtimeDBService
                .updateWatertankAndPumpStatus(productKeyandType[0]);
            print('(UPDATE) executeTask:watertank productkey : ' +
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return OverlaySupport(
      child: MaterialApp(
        //home: AuthenticateView(), //if want ot test view
        initialRoute: AR.Routes.wrapperViewRoute,
        onGenerateRoute: AR.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}

// WidgetsFlutterBinding.ensureInitialized();
//   //await setupLocator();
//   final RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();

// if (task == UPDATEDBTASK) {
//       print("Update DB");
//       List<String> listProductToUpdate = inputData['list'];
//       for (int i = 0; i < listProductToUpdate.length; i++) {
//         //productKeyandType[0] = product key
//         //productKeyandType[1] = product type
//         List productKeyandType = listProductToUpdate[i].split('_');
//         if (productKeyandType[1] == WATERTANKMONITORING) {
//           await _realtimeDBService
//               .updateWatertankAndPumpStatus(productKeyandType[0]);
//         }
//       }
//     }

// bool result = await _realtimeDBService
//               .updateWatertankAndPumpStatus(productKeyandType[0]);
//           print('(UPDATE) executeTask:watertank productkey : ' +
//               productKeyandType[0] +
//               ' || result :$result');

// if (productKeyandType[1] == WATERTANKMONITORING) {
//   print(productKeyandType[0]);
// }
