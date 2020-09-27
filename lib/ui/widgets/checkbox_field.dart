import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CheckBoxField extends StatefulWidget {
  final String message;
  final bool value;
  final Function onChanged;
  CheckBoxField(
      {@required this.onChanged, @required this.value, @required this.message});

  @override
  _CheckBoxFieldState createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
            value: widget.value,
            onChanged: (val) {
              widget.onChanged();
            }),
        horizontalSpaceSmall,
        Text(widget.message)
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
