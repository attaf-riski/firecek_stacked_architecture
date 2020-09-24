import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends ReactiveViewModel {
  AuthToggleState _authToggleState = locator<AuthToggleState>();
  bool _isObscurePassword = true;
  bool get isObscurePassword => _isObscurePassword;

  void toogleObscurePassword() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void toSignInView() {
    _authToggleState.toggleAuth();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authToggleState];
}
