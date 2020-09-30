import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WrapperViewModel extends FutureViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool hasLoggedInUser = false;
  Future handleStartUpLogic() async {
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