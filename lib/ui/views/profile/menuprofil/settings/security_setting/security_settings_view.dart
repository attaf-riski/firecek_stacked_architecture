import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/settings_app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SecuritySettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsAppViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            TopBackground(
              title: 'Security & Privacy Settings',
              height: MediaQuery.of(context).size.height * 0.2,
              backButton: () => model.backButton(),
            ),
            SizedBox(
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
                      if (model.isBiometricHasSetupped ?? false)
                        if (model.currentEmailEqualsBiometricEmail ?? false)
                          ListTile(
                            leading: Icon(Icons.remove),
                            title: Text('Reset Fingerprint'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              await model.resetBiometric();
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
