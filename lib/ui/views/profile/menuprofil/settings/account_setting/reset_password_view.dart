import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/security_setting/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StatelessWidget {
  final bool inside;
  ResetPasswordView({this.inside = false});
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: (model.isBusy)
              ? Loading()
              : ListView(
                  children: [
                    TopBackground(
                        title: 'Reset Password',
                        height: MediaQuery.of(context).size.height * 0.2,
                        backButton: () => model.backButton()),
                    Padding(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Text((inside)
                                ? 'We will send a link for reset your password to your register email, please check below.'
                                : 'We will send a link for reset your password to your register email, please fill email.'),
                            verticalSpaceMedium,
                            InputField(
                              controller: _emailController,
                              placeholder: (inside) ? model.getEmail : 'email',
                              textInputAction: TextInputAction.done,
                              fieldFocusNode: _emailFocusNode,
                            ),
                            verticalSpaceMedium,
                            SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                    color: Colors.lightBlue,
                                    child: Text(
                                      "Send To Email",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      await model.sendLinkToEmail(
                                          _emailController.text);
                                    })),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      padding: const EdgeInsets.all(60.0),
                    )
                  ],
                )),
      onModelReady: (model) {
        if (inside) {
          model.loadCurrentEmail();
        }
      },
      viewModelBuilder: () => ResetPasswordViewModel(),
    );
  }
}
