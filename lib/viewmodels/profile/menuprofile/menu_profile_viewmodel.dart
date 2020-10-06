import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/settings_app_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MenuProfileViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final DialogService _dialogService = locator<DialogService>();
  //for signOut
  Future sigOut() async {
    var result = await _dialogService.showConfirmationDialog(
        cancelTitle: 'Cancel',
        confirmationTitle: 'Sign Out',
        dialogPlatform: DialogPlatform.Material,
        title: 'Are you sure?',
        description: 'Are you sure to sign out?');
    //unsubribe to all user topic subscription
    //unsubribe to all user product
    //take user data from firestore
    if (result.confirmed) {
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
  }

  //push to settings
  Future pushToSettings() async {
    await _navigationService.navigateWithTransition(SettingAppView(),
        duration: fastDurationTransition, transition: 'rightToLeft');
  }
}
