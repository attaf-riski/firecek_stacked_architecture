import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double height;
  Loading({this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitPouringHourglass(
          color: Colors.orange,
          size: 90.0,
        ),
      ),
      height: height ?? MediaQuery.of(context).size.height,
    );
  }
}
