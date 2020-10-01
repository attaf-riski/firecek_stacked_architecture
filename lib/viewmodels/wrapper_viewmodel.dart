import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WrapperViewModel extends FutureViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  bool hasLoggedInUser = false;
  Future handleStartUpLogic() async {
    //to initialise notification
    await _pushNotificationService.initialise();
    hasLoggedInUser = await _authService.isUserLoggedIn();
    if (hasLoggedInUser == true) {
      _navigationService.replaceWith(Routes.homeViewRoute);
    } else {
      _navigationService.replaceWith(Routes.authenticateViewRoute);
    }
  }

  @override
  Future futureToRun() => handleStartUpLogic();
}
