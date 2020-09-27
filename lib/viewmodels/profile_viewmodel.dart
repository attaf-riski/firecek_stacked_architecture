import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future sigOut() async {
    var result = await _authService.signOut();
    if (result == true) {
      _navigationService.replaceWith(Routes.authenticateViewRoute);
    }
  }
}
