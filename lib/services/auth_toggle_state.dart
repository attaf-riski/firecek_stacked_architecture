import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class AuthToggleState with ReactiveServiceMixin {
  //reactive, it is for detect if there exist a change
  RxValue<bool> _isSignIn = RxValue<bool>(initial: false);

  AuthToggleState() {
    listenToReactiveValues([_isSignIn]);
  }

  bool get isSignIn => _isSignIn.value;

  void toggleAuth() {
    _isSignIn.value = !_isSignIn.value;
  }
}
