import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:stacked/stacked.dart';

class AuthenticateViewModel extends ReactiveViewModel {
  final AuthToggleState _authToggleState = locator<AuthToggleState>();
  bool get isSignIn => _authToggleState.isSignIn;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authToggleState];
}
