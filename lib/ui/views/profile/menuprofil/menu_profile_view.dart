import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/settings/item_menu_profile_view.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/menu_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MenuProfileView extends StatelessWidget {
  final double height;
  MenuProfileView({this.height});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuProfileViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            ItemMenuProfileView(
                iconData: Icons.person_add,
                title: 'Profile Customize',
                height: 50,
                width: MediaQuery.of(context).size.width,
                onTap: () async => model.pushToProfileCustomize()),
            ItemMenuProfileView(
              iconData: Icons.settings,
              title: 'Settings',
              height: 50,
              width: MediaQuery.of(context).size.width,
              onTap: () async => model.pushToSettings(),
            ),
            ItemMenuProfileView(
              iconData: Icons.exit_to_app,
              title: 'Sign Out',
              height: 50,
              width: MediaQuery.of(context).size.width,
              onTap: () async => await model.sigOut(),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
        height: height,
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<MenuProfileViewModel>(),
    );
  }
}
