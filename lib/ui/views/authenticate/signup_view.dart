import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Form(
        child: Column(
          children: [
            Text(
              'error',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Fill For Your Accounr Information",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: inputDecoration.copyWith(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill email!";
                }
                return null;
              },
              onChanged: (val) {
                //setState(() => email = val);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: inputDecoration.copyWith(
                  labelText: 'Password',
                  suffix: IconButton(
                      icon: Icon((model.isObscurePassword)
                          ? Icons.remove_red_eye
                          : Icons.not_interested),
                      onPressed: () {
                        model.toogleObscurePassword();
                      })),
              obscureText: model.isObscurePassword,
              validator: (value) {
                if (value.length < 6) {
                  return "Please password 6+ character!";
                }
                return null;
              },
              onChanged: (val) {
                //setState(() => pass = val);
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    color: Colors.lightBlue,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {})),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  model.toSignInView();
                },
                child: Text("Back To Sign In")),
          ],
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
