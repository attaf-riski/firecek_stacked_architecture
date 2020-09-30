import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/widgets/profile_card.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, model, child) => (model.isBusy)
          ? Loading()
          : SizedBox(
              child: Stack(
                children: [
                  Center(
                      child: Column(
                    children: [],
                  )),
                  ProfileCard(
                    email: model.userData.email,
                    imageURL: model.userData.imageURL,
                    name: model.userData.userName,
                  ),
                  Center(
                    child: RaisedButton(onPressed: () async {
                      await model.sigOut();
                    }),
                  ),
                ],
              ),
            ),
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (model) => model.listenToUserData(),
      viewModelBuilder: () => locator<ProfileViewModel>(),
    );
  }
}
