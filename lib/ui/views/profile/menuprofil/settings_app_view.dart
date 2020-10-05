import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings_app_viewmodel.dart';
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
            Container(
              child: ListView(
                children: ListTile.divideTiles(
                    color: Colors.black,
                    context: context,
                    tiles: [
                      if (!model.isBiometricHasSetupped)
                        ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add Fingerprint'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () async {
                            await model.biometricPopUp();
                          },
                        ),
                      ListTile(
                        leading: Icon(Icons.remove),
                        title: Text('Reset Fingerprint'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          await model.resetBiometric();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.remove),
                        title: Text('Change Password'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          print('horse');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.remove),
                        title: Text('Reset Password'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          print('horse');
                        },
                      ),
                    ]).toList(),
              ),
              height: MediaQuery.of(context).size.height * 0.8,
            )
          ],
        ),
      ),
      viewModelBuilder: () => SettingsAppViewModel(),
    );
  }
}
