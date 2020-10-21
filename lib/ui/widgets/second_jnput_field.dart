import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class SecondInputField extends StatelessWidget {
  final double height, width;
  final String initialData;
  final String zoneKey;
  final Function onSubmitted;
  final FocusNode fieldFocusNode;
  final Color colorTheme;
  final int maxLength;
  final bool isSmallSize;
  SecondInputField(
      {this.zoneKey,
      this.isSmallSize = false,
      this.maxLength = 20,
      this.width,
      this.colorTheme,
      this.fieldFocusNode,
      this.onSubmitted,
      this.initialData,
      this.height = 40});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  if (isSmallSize) verticalSpaceMedium,
                  TextFormField(
                    decoration: inputDecoration.copyWith(
                        suffixIcon: Icon(
                      Icons.edit,
                      color: colorTheme,
                      size: (isSmallSize) ? 0 : 22,
                    )),
                    focusNode: fieldFocusNode,
                    style: TextStyle(
                      color: colorTheme ?? Colors.white,
                      fontSize: (isSmallSize) ? 15 : 18,
                    ),
                    initialValue: initialData,
                    onFieldSubmitted: (value) {
                      isSmallSize
                          ? onSubmitted(zoneKey, value)
                          : onSubmitted(value);

                      fieldFocusNode.unfocus();
                    },
                  ),
                ],
              ),
              height: height,
              padding: isSmallSize ? smallFieldPadding : fieldPadding,
              width: width ?? 150,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      height: height,
    );
  }
}
