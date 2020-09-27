import 'package:firecek_stacked_architecture/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            Center(
              child: Text('profile'),
            ),
            RaisedButton(onPressed: () async {
              await model.sigOut();
            }),
          ],
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
