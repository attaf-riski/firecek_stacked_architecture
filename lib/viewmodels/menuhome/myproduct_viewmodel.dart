import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:stacked/stacked.dart';
import 'package:workmanager/workmanager.dart';
import '../../main.dart';

class MyProductViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  //user data
  UserData _userData;
  //getter
  UserData get userData => _userData;
  //listen to firestore user data stream
  Future listenToUserData() async {
    setBusy(true);
    User user = await _authService.userUIDAndEmail;
    _firestoreService
        .listenToUserDataRealTime(user.uid, user.email)
        .listen((result) async {
      _userData = result;
      //berbahaya
      //Workmanager.cancelByTag(UPDATEDBTAG);
      await initialize();
      setBusy(false);
      notifyListeners();
    });
  }

  Future initialize() async {
    print('initializ');
    await Workmanager.initialize(callbackDispatcher,
        // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    await Workmanager.registerPeriodicTask(UPDATEDBUNIQUE, UPDATEDBTASK,
        constraints: Constraints(networkType: NetworkType.connected),
        tag: UPDATEDBTAG,
        frequency: updateDBDuration);
  }
}
