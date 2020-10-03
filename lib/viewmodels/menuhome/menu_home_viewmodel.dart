import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MenuHomeViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  //for signOut
  Future sigOut() async {
    //unsubribe to all user topic subscription
    //unsubribe to all user product
    //take user data from firestore
    User user = await _authService.userUIDAndEmail;
    UserData userData =
        await _firestoreService.userDataFuture(user.uid, user.email);
    //take list myProduct from user data
    List productNameForTopic = userData.myProduct;
    //unsubribe to topic with name of product user
    productNameForTopic.forEach((element) async {
      List productKey = element.split('_');
      //product key 0 = productKey
      //product key 1 = productType
      //
      //unsubribe to all product in myProduct
      await _pushNotificationService.unsubscribeToTopic(productKey[0]);
      //set button on/off notif in myproduct detail to on all
      _localStorageService.setIsSubscribeToThisTopic(productKey[0], false);
    });
    var result = await _authService.signOut();
    if (result == true) {
      _navigationService.replaceWith(Routes.authenticateViewRoute);
    }
  }

  //user data
  UserData _userData;
  //getter
  UserData get userData => _userData;
  //listen to firestore user data stream
  void listenToUserData() async {
    setBusy(true);
    User user = await _authService.userUIDAndEmail;
    _firestoreService
        .listenToUserDataRealTime(user.uid, user.email)
        .listen((result) {
      _userData = result;
    });
    Future.delayed(loadingTime, () {
      notifyListeners();
      setBusy(false);
    });
  }
}
