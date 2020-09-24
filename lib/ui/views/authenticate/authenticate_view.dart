import 'package:firecek_stacked_architecture/ui/views/authenticate/signin_view.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'authenticate_viewmodel.dart';

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
                        child: (model.isSignIn) ? SignInView() : SignUpView(),
                      ),
                    ),
                  ),
                ],
              ),
              resizeToAvoidBottomInset: true,
            ),
        viewModelBuilder: () => AuthenticateViewModel());
  }
}
