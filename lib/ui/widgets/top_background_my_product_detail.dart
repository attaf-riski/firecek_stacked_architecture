import 'package:firecek_stacked_architecture/shared/enums.dart';
import 'package:flutter/material.dart';

class TopBackGroundMyProductDetail extends StatelessWidget {
  final ConnectivityStatus connectivityStatus;
  final bool waterTankMonitorStatus;
  final Function backButton;
  TopBackGroundMyProductDetail(
      {this.backButton,
      this.connectivityStatus = ConnectivityStatus.Cellular,
      this.waterTankMonitorStatus = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
                onPressed: () => backButton()),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width / 3.5), top: 5.0),
            child: Text(
              (waterTankMonitorStatus) ? 'WELMO' : 'OFFLINE',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Futura',
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/header.jpg'),
              fit: BoxFit.cover)),
    );
  }
}
