import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  //product data
  Product _product;
  get product => _product;
  set product(Product product) {
    _product = product;
    notifyListeners();
  }

  //backbutton
  void backButton() {
    _navigationService.back();
  }
}
