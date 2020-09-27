import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //state for checkbox
  bool _isCheck = false;

  //setter _isCheck
  void setIsCek() {
    _isCheck = !_isCheck;
    notifyListeners();
  }

  //getter
  get getIsCheck => _isCheck;

  //sign in with firebase
  Future signIn(String email, String password) async {
    //for show loading ui
    setBusy(true);
    var result =
        await _authService.sigInWithEmail(email: email, password: password);
    if (result == true) {
      //stop show loading ui
      setBusy(false);
      _navigationService.replaceWith(Routes.homeViewRoute,
          arguments: HomeViewArguments(isCheckBiometric: _isCheck));
    } else if (result is String) {
      //stop show loading ui
      setBusy(false);
      await _dialogService.showDialog(
        title: 'Login Failed',
        description: result,
        dialogPlatform: DialogPlatform.Material,
      );
    }
  }
}
