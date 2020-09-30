import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name, email, imageURL;
  ProfileCard({this.name, this.email, this.imageURL});

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
                  image: NetworkImage(imageURL),
                  fit: BoxFit.cover,
                ),
                height: 100,
                width: 100,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            Text(
              name ?? '',
              style: profileCardTextStyle.copyWith(fontSize: 25),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              email ?? '',
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
