import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/viewmodels/authenticate/signin_viewmodel.dart';
import 'package:firecek_stacked_architecture/ui/widgets/checkbox_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (context, model, child) => (model.isBusy)
          ? Loading()
          : Column(
              children: [
                Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                verticalSpaceMedium,
                Text(
                  "Sign In with your account!",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                verticalSpaceMedium,
                InputField(
                  controller: _emailController,
                  fieldFocusNode: _emailFocus,
                  nextFocusNode: _passwordFocus,
                  placeholder: 'Email',
                  validationMessage: "*Please enter your account email address",
                ),
                verticalSpaceMedium,
                InputField(
                  controller: _passwordController,
                  fieldFocusNode: _passwordFocus,
                  placeholder: 'Password',
                  password: true,
                  textInputAction: TextInputAction.done,
                  validationMessage: "*Please enter your account password",
                ),
                (model.isHasSetupBiometric)
                    ? Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.fingerprint,
                                size: 50,
                              ),
                              onPressed: model.biometricPopUp),
                          verticalSpaceSmall,
                          Text('Login with fingerprint / face recognition'),
                        ],
                      )
                    : CheckBoxField(
                        message: 'Login with fingerprint / face recognition',
                        onChanged: () => model.setIsCek(),
                        value: model.isCheck,
                      ),
                verticalSpaceLarge,
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          model.signIn(
                              email: _emailController.text,
                              password: _passwordController.text);
                        })),
              ],
            ),
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}
