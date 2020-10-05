import 'package:firecek_stacked_architecture/ui/widgets/material_inkwell.dart';
import 'package:flutter/material.dart';

class ItemMenuProfileView extends StatelessWidget {
  final IconData iconData;
  final String title;
  final TextStyle textStyle;
  final double height, width;
  final Function onTap;
  ItemMenuProfileView(
      {this.onTap,
      this.height,
      this.width,
      this.iconData,
      this.title,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(1, 1))]),
      child: MaterialInkwell(
        backgroundColor: Colors.transparent,
        borderRadiusValue: 25,
        child: Row(
          children: [
            SizedBox(
              child: Icon(
                iconData,
                size: 35,
              ),
              width: width * 0.2,
            ),
            SizedBox(
              child: Text(
                title,
                style: textStyle ??
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              width: width * 0.7,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        onTap: onTap,
        splashColor: Colors.lightBlue[50],
      ),
      height: height,
      width: width,
    );
  }
}
