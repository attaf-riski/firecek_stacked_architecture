import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/settings/appearance_setting/text_size_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TextSizeSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TextSizeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            TopBackground(
              title: 'Text Size Settings',
              height: MediaQuery.of(context).size.height * 0.2,
              backButton: () => model.backButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: SizedBox(
                child: Column(children: [
                  Text(
                      'This text size just affects inside your product menu. Drag the slider.'),
                  verticalSpaceMassive,
                  Center(
                    child: Slider(
                      divisions: 2,
                      label: model.labelSlider,
                      min: -5,
                      max: 5,
                      value: model.sliderValue,
                      onChanged: (double value) {
                        model.setSliderValue(value);
                      },
                    ),
                  )
                ]),
                height: MediaQuery.of(context).size.height * 0.8 - 120,
              ),
            )
          ],
        ),
      ),
      onModelReady: (model) => model.loadTextSize(),
      viewModelBuilder: () => TextSizeViewModel(),
    );
  }
}
