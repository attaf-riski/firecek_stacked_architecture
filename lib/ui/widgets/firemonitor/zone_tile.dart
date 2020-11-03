import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

import '../second_jnput_field.dart';

class ZoneTile extends StatelessWidget {
  final String title, subtitle, imagePath, zoneKey;
  final Function onSubmitted;
  final Color color;
  final bool isWhiteColor, isZone;
  final FocusNode focusNode;
  final double addTextSize;
  ZoneTile({
    this.addTextSize,
    this.zoneKey,
    this.onSubmitted,
    this.focusNode,
    this.isZone = false,
    this.imagePath,
    this.isWhiteColor = false,
    this.color,
    this.title,
    this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (isZone)
            Row(
              children: [
                SecondInputField(
                    height: 85,
                    width: 150,
                    fieldFocusNode: focusNode,
                    initialData: subtitle ?? 'empty',
                    onSubmitted: onSubmitted,
                    isSmallSize: true,
                    colorTheme: isWhiteColor ? Colors.white : Colors.black45,
                    zoneKey: zoneKey),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          Center(
            child: Row(
              children: [
                horizontalSpaceSmall,
                Column(
                  children: [
                    Text(
                      title,
                      style: fireMonitorZonetextStyle.copyWith(
                          color: isWhiteColor ? Colors.white : Colors.black45,
                          fontSize: 20 + addTextSize),
                    ),
                    (isZone)
                        ? Text('')
                        : Text(
                            subtitle,
                            style: fireMonitorZonetextStyle.copyWith(
                                color: isWhiteColor
                                    ? Colors.white
                                    : Colors.black45,
                                fontSize: 15 + addTextSize),
                          )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Spacer(
                  flex: 1,
                ),
                if (!isZone && imagePath != null)
                  SizedBox(
                    child: Image(
                      image: AssetImage(imagePath),
                    ),
                    height: (isZone) ? 70 : 70,
                    width: (isZone) ? 70 : 80,
                  ),
                horizontalSpaceSmall,
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 2),
          image: (isZone)
              ? (imagePath == null)
                  ? null
                  : DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover)
              : null),
    );
  }
}
