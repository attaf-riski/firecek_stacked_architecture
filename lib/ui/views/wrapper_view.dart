import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/ui/views/wrapper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WrapperView extends StatelessWidget {
  const WrapperView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WrapperViewModel>.reactive(
        onModelReady: (model) => model.handleStartUpLogic(),
        builder: (context, model, child) => Scaffold(
              body: Loading(),
            ),
        viewModelBuilder: () => WrapperViewModel());
  }
}
