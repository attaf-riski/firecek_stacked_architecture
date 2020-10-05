import 'package:flutter/material.dart';

class MaterialInkwell extends StatelessWidget {
  final Color backgroundColor, splashColor;
  final Function onTap;
  final Widget child;
  final double borderRadiusValue;
  MaterialInkwell(
      {this.borderRadiusValue,
      this.backgroundColor,
      this.splashColor,
      this.child,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: child,
        splashColor: splashColor,
        onTap: onTap,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
    );
  }
}
