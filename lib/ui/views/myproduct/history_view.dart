import 'package:firecek_stacked_architecture/models/history.dart';
import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HistoryView extends StatelessWidget {
  final List productHistory;
  HistoryView({this.productHistory});

  @override
  Widget build(BuildContext context) {
    print(productHistory);
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: ListView(
          children: [
            TopBackground(
              backButton: model.backButton,
              title: 'History',
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            (productHistory.isEmpty)
                ? LottieMessage(
                    height: MediaQuery.of(context).size.height * 0.75,
                    lottiePath: 'assets/lottie/empty.json',
                    title: 'No History',
                  )
                : SizedBox(
                    child: ListView.builder(
                        itemCount: productHistory.length,
                        itemBuilder: (context, index) {
                          HistoryModel historyModel = productHistory[index];
                          return Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Event : " + historyModel.event),
                                  Text("Date : " + historyModel.date),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                              ),
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                            ),
                            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                            shadowColor: Colors.grey,
                          );
                        }),
                    height: MediaQuery.of(context).size.height * 0.75)
          ],
        ),
      ),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}
