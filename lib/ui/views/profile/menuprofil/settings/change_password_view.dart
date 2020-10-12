import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/change_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordView extends StatelessWidget {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final FocusNode _currentPasswordFocusNode = FocusNode();
  final TextEditingController _newPasswordController = TextEditingController();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final TextEditingController _doubleCheckNewPasswordController =
      TextEditingController();
  final FocusNode _doubleCheckNewPasswordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: (model.isBusy)
              ? Loading()
              : ListView(
                  children: [
                    TopBackground(
                        title: 'Change Password',
                        height: MediaQuery.of(context).size.height * 0.2,
                        backButton: () => model.backButton()),
                    Padding(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Text('Current Password:'),
                            InputField(
                              controller: _currentPasswordController,
                              fieldFocusNode: _currentPasswordFocusNode,
                              nextFocusNode: _newPasswordFocusNode,
                              placeholder: 'Current password.',
                              password: true,
                            ),
                            verticalSpaceSmall,
                            Text('New Password:'),
                            InputField(
                              controller: _newPasswordController,
                              fieldFocusNode: _newPasswordFocusNode,
                              nextFocusNode: _doubleCheckNewPasswordFocusNode,
                              placeholder: 'New password.',
                              additionalNote: '*Please enter 6+ character.',
                              password: true,
                            ),
                            verticalSpaceSmall,
                            Text('Type again new Password:'),
                            InputField(
                              controller: _doubleCheckNewPasswordController,
                              fieldFocusNode: _doubleCheckNewPasswordFocusNode,
                              placeholder: 'Type again new password.',
                              textInputAction: TextInputAction.done,
                              password: true,
                            ),
                            verticalSpaceMedium,
                            SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                    color: Colors.lightBlue,
                                    child: Text(
                                      "Update Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      await model.updatePassword(
                                          currentPassword:
                                              _currentPasswordController.text,
                                          newPassword:
                                              _newPasswordController.text,
                                          againNewPassword:
                                              _doubleCheckNewPasswordController
                                                  .text);
                                    })),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      padding: const EdgeInsets.all(60.0),
                    )
                  ],
                )),
      onModelReady: (model) {},
      viewModelBuilder: () => ChangePasswordViewModel(),
    );
  }
}
