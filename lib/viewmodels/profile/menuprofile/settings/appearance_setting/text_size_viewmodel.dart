import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TextSizeViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  //backButton

  String labelSlider = 'Normal';
  double _sliderValue = 0;
  get sliderValue => _sliderValue;
  setSliderValue(double newValue) async {
    _sliderValue = newValue;
    if (newValue == -5.0) {
      labelSlider = 'Little';
      _localStorageService.textSize = newValue;
    } else if (newValue == 0.0) {
      labelSlider = 'Normal';
      _localStorageService.textSize = newValue;
    } else if (newValue == 5.0) {
      labelSlider = 'Big';
      _localStorageService.textSize = newValue;
    }
    notifyListeners();
  }

  backButton() {
    _navigationService.back();
  }

  loadTextSize() async {
    setSliderValue(await _localStorageService.textSize);
  }
}
