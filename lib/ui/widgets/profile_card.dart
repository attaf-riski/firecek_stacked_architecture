import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final UserData userData;
  ProfileCard({this.userData});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: Center(
            child: Column(
          children: [
            ClipRRect(
              child: SizedBox(
                child: Image(
                  image: NetworkImage(userData.imageURL),
                  fit: BoxFit.cover,
                ),
                height: 100,
                width: 100,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            Text(
              userData.userName ?? '',
              style: profileCardTextStyle.copyWith(fontSize: 25),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              userData.email ?? '',
              style: profileCardTextStyle.copyWith(fontSize: 25),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )),
        decoration: profileCardDecortaion,
        height: 200,
        margin: EdgeInsets.only(top: 90),
        width: MediaQuery.of(context).size.width * 0.85,
      ),
    );
  }
}
