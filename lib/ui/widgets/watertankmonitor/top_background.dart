import 'package:flutter/material.dart';

class TopBackground extends StatelessWidget {
  final String title;
  final double height;
  final Function backButton;
  final bool isUsingBackButton;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double paddingTop;
  TopBackground(
      {@required this.title,
      this.height,
      this.backButton,
      this.isUsingBackButton = true,
      this.textStyle,
      this.backgroundColor = Colors.transparent,
      this.paddingTop = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            if (isUsingBackButton)
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
                child: Padding(
                  child: Text(
                    title,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 30,
                        ),
                  ),
                  padding: EdgeInsets.only(top: paddingTop),
                ))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        color: backgroundColor,
        height: height,
        width: MediaQuery.of(context).size.width);
  }
}
