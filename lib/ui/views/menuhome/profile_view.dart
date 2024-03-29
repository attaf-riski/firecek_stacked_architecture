import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/views/profile/menuprofil/menu_profile_view.dart';
import 'package:firecek_stacked_architecture/ui/widgets/profile_card.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
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
                    userData: model.userData,
                  ),
                ],
              ),
            ),
      onModelReady: (model) async => await model.listenToUserData(),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
