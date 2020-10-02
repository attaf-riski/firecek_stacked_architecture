import 'package:firecek_stacked_architecture/models/myproduct.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertankmonitor/settings_watertankmonitor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsWaterTankMonitorView extends StatelessWidget {
  final String productKey;
  final WaterTankMonitor waterTankMonitor;
  SettingsWaterTankMonitorView({this.productKey, this.waterTankMonitor});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productHeightController =
      TextEditingController();
  final TextEditingController _limitSurfaceHeigtController =
      TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widhtController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _productHeightFocus = FocusNode();
  final FocusNode _limitSurfaceHeigtFocus = FocusNode();
  final FocusNode _lengthFocus = FocusNode();
  final FocusNode _widhtFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsWaterTankMonitorViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
                body: ListView(children: [
              TopBackground(
                backButton: model.backButton,
                title: 'Settings Watertank Monitor',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                child: Column(children: [
                  Text('Name:'),
                  InputField(
                      controller: _nameController,
                      fieldFocusNode: _nameFocus,
                      nextFocusNode: _productHeightFocus,
                      placeholder: waterTankMonitor.name),
                  verticalSpaceSmall,
                  Text('Watertank Height:(centimeter)'),
                  InputField(
                    controller: _productHeightController,
                    fieldFocusNode: _productHeightFocus,
                    nextFocusNode: _limitSurfaceHeigtFocus,
                    placeholder: waterTankMonitor.fixDistance.toString(),
                    textInputType: TextInputType.number,
                  ),
                  verticalSpaceSmall,
                  Text('Limit Water Surface Height:(centimeter)'),
                  InputField(
                    controller: _limitSurfaceHeigtController,
                    fieldFocusNode: _limitSurfaceHeigtFocus,
                    nextFocusNode: _lengthFocus,
                    placeholder: waterTankMonitor.limit.toString(),
                    textInputType: TextInputType.number,
                    additionalNote:
                        '*You will get notification if water surface height under this limit',
                  ),
                  verticalSpaceSmall,
                  Text('Watertank Length:(centimeter)'),
                  InputField(
                    controller: _lengthController,
                    fieldFocusNode: _lengthFocus,
                    nextFocusNode: _widhtFocus,
                    placeholder: 'number',
                    textInputType: TextInputType.number,
                  ),
                  verticalSpaceSmall,
                  Text('Watertank Width:(centimeter)'),
                  InputField(
                    controller: _widhtController,
                    fieldFocusNode: _widhtFocus,
                    placeholder: 'number',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                  ),
                  verticalSpaceMedium,
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          color: Colors.lightBlue,
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            ////////////espesially for search volume////////////////
                            bool lengthAndWidhtNotNull = model.searchVolume(
                                _widhtController.text, _lengthController.text);
                            int volume = model.searchVolume(
                                _widhtController.text, _lengthController.text,
                                isReturnBool: false);
                            ////////////espesially for search volume////////////////
                            model.updateSettings(
                              name: (_nameController.text != '')
                                  ? _nameController.text
                                  : waterTankMonitor.name,
                              fixDistance: (_productHeightController.text != '')
                                  ? int.parse(_productHeightController.text)
                                  : waterTankMonitor.fixDistance,
                              limit: (_limitSurfaceHeigtController.text != '')
                                  ? int.parse(_limitSurfaceHeigtController.text)
                                  : waterTankMonitor.limit,
                              volumeSet: (lengthAndWidhtNotNull)
                                  ? volume
                                  : waterTankMonitor.volumeSet,
                            );
                          })),
                ], crossAxisAlignment: CrossAxisAlignment.start),
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(20.0),
              )
            ])),
        onModelReady: (model) => model.productKey = productKey,
        disposeViewModel: true,
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => SettingsWaterTankMonitorViewModel());
  }
}
