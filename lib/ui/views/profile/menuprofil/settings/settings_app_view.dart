import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/settings_app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsAppViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            TopBackground(
              title: 'Settings',
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
                        leading: Icon(Icons.person),
                        title: Text('Account'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.pushToAccountSettings();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.remove_red_eye),
                        title: Text('Appearance'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.pushToAppearanceSettings();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Privacy & Security'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.pushToSecuritySettings();
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
