import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HistoryViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  //backbutton
  void backButton() {
    _navigationService.back();
  }
}
