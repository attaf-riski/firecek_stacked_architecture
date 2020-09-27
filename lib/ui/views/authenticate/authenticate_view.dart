import 'package:firecek_stacked_architecture/ui/views/authenticate/signin_view.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../viewmodels/authenticate_viewmodel.dart';
import 'package:animations/animations.dart';

class AuthenticateView extends StatelessWidget {
  const AuthenticateView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticateViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: SizedBox(
                      child: Center(
                        child: PageTransitionSwitcher(
                          duration: const Duration(milliseconds: 1500),
                          reverse: true,
                          transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                          ) {
                            return SharedAxisTransition(
                              child: child,
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType:
                                  SharedAxisTransitionType.horizontal,
                            );
                          },
                          child: (model.isSignIn) ? SignInView() : SignUpView(),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        model.toChangeView();
                      },
                      child: (model.isSignIn)
                          ? Text("Doesn't have account? Click Here!")
                          : Text("Back To Sign In")),
                  Visibility(
                    child: FlatButton(
                        onPressed: () {}, child: Text('Forget Password? ')),
                    visible: model.isSignIn,
                  )
                ],
              ),
              resizeToAvoidBottomInset: true,
            ),
        viewModelBuilder: () => AuthenticateViewModel());
  }
}
