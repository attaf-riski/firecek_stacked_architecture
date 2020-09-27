import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/authenticate_view.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/authenticate_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';

class WrapperViewModel extends FutureViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool hasLoggedInUser = false;
  Future handleStartUpLogic() async {
    hasLoggedInUser = await _authService.isUserLoggedIn();
    if (hasLoggedInUser == true) {
      _navigationService.replaceWithTransition(
        HomeView(),
        duration: durationTransition,
        transition: NavigationTransition.Fade,
      );
    } else {
      _navigationService.replaceWithTransition(
        AuthenticateView(),
        duration: durationTransition,
        transition: NavigationTransition.Fade,
      );
    }
  }

  @override
  Future futureToRun() => handleStartUpLogic();
}
