import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/menu_profile_view.dart';
import 'package:firecek_stacked_architecture/ui/widgets/profile_card.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/menu_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuHomeViewModel>.reactive(
      builder: (context, model, child) => (model.isBusy)
          ? Loading()
          : SizedBox(
              child: Stack(
                children: [
                  Center(
                      child: Column(
                    children: [
                      TopBackground(
                        title: 'PROFILE',
                        isUsingBackButton: false,
                        backgroundColor: Colors.lightBlue,
                        height: MediaQuery.of(context).size.height * 0.3,
                        paddingTop: 30,
                        textStyle: profileTitleTextStyle.copyWith(fontSize: 40),
                      ),
                      MenuProfileView(
                        height: MediaQuery.of(context).size.height * 0.4,
                      )
                    ],
                  )),
                  ProfileCard(
                    email: model.userData.email,
                    imageURL: model.userData.imageURL,
                    name: model.userData.userName,
                  ),
                ],
              ),
            ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (model) => model.listenToUserData(),
      viewModelBuilder: () => locator<MenuHomeViewModel>(),
    );
  }
}
