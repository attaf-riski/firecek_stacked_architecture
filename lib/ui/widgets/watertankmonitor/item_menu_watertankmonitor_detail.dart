import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';

class ItemWaterTankMonitordetail extends StatelessWidget {
  final String title;
  final bool isNeedBackground;
  final List<String> content;
  final List<bool> isPumpOrStatusOn;
  final double cardHeight;
  final Color cardColor;
  final Color fontColor;
  final double fontSize;
  final double addTextSize;
  ItemWaterTankMonitordetail({
    this.addTextSize,
    this.fontSize,
    this.fontColor = Colors.black,
    this.cardColor,
    this.cardHeight = 75.0,
    this.title,
    this.content,
    this.isNeedBackground = false,
    this.isPumpOrStatusOn,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? Color(0xffe4f2fd),
      child: SizedBox(
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                    child: Text(title,
                        style: textStyleJudul.copyWith(
                            fontSize: 13 + addTextSize))),
              ),
            for (int i = 0; i < content.length; i++)
              Container(
                child: Center(
                  child: Text(
                    content[i],
                    textAlign: TextAlign.center,
                    style: (title == null)
                        ? textStyleButton.copyWith(
                            color: fontColor,
                            fontSize: (fontSize != null)
                                ? fontSize + addTextSize
                                : 15.0 + addTextSize)
                        : (isNeedBackground)
                            ? textStyleAngka.copyWith(
                                color: fontColor,
                                fontSize: (fontSize != null)
                                    ? fontSize + addTextSize
                                    : 15.0 + addTextSize)
                            : textStyleAngka.copyWith(
                                color: fontColor,
                                fontSize: (fontSize != null)
                                    ? fontSize + addTextSize
                                    : 20.0 + addTextSize),
                    maxLines: 2,
                  ),
                ),
                decoration: (isNeedBackground)
                    ? BoxDecoration(
                        image: (isPumpOrStatusOn[i] ?? false)
                            ? DecorationImage(
                                image: AssetImage('assets/images/alert.png'),
                                fit: BoxFit.cover)
                            : null,
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xffbbdefa))
                    : null,
                margin: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                height: 40.0,
                width: MediaQuery.of(context).size.width * 0.6,
              )
          ],
        ),
        height: cardHeight,
      ),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
