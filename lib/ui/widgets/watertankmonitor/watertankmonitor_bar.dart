import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';

class WaterTankMonitorBar extends StatelessWidget {
  final Color waterColor;
  final Color waterColorOppacity;
  final double ratio;
  WaterTankMonitorBar({this.ratio, this.waterColor, this.waterColorOppacity});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: waterColor,
            borderRadius: BorderRadius.circular(25),
          ),
          duration: waterChange,
          height: (MediaQuery.of(context).size.height * 0.8) * ratio,
          width: MediaQuery.of(context).size.width * 0.32,
        ),
      ),
      decoration: BoxDecoration(
        color: waterColorOppacity,
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 0.32,
      margin: EdgeInsets.fromLTRB(20, 0, 10, 30),
    );
  }
}
