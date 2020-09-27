import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/viewmodels/signup_viewmodel.dart';
import 'package:firecek_stacked_architecture/ui/widgets/checkbox_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => (model.isBusy)
          ? Loading()
          : Column(
              children: [
                Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                verticalSpaceMedium,
                Text(
                  "Input data for your account!",
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
                CheckBoxField(
                  message: 'Login with fingerprint / face recognition',
                  onChanged: () => model.setIsCek(),
                  value: model.getIsCheck,
                ),
                verticalSpaceLarge,
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await model.signUp(
                              _emailController.text, _passwordController.text);
                        })),
              ],
            ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
