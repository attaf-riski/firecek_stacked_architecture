import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/settings_app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AccountSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsAppViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            TopBackground(
              title: 'Account Settings',
              height: MediaQuery.of(context).size.height * 0.2,
              backButton: () => model.backButton(),
            ),
            SizedBox(
              child: ListView(
                children: ListTile.divideTiles(
                    color: Colors.black,
                    context: context,
                    tiles: [
                      ListTile(
                        leading: Icon(Icons.remove),
                        title: Text('Change Password'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.pushToChangePassword();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.remove),
                        title: Text('Reset Password'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.pushToResetPassword();
                        },
                      ),
                    ]).toList(),
              ),
              height: MediaQuery.of(context).size.height * 0.8,
            )
          ],
        ),
      ),
      onModelReady: (model) => model.checkIsCurrentEmailEqualsBiometricEmail(),
      viewModelBuilder: () => SettingsAppViewModel(),
    );
  }
}
