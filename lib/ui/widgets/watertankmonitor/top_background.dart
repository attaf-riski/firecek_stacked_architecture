import 'package:flutter/material.dart';

class TopBackground extends StatelessWidget {
  final String title;
  final double height;
  final Function backButton;
  TopBackground({@required this.title, this.height, this.backButton});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  onPressed: () => backButton()),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        height: height,
        width: MediaQuery.of(context).size.width);
  }
}
