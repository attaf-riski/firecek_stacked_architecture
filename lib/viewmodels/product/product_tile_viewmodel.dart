import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/views/product/product_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductTileViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  //product data
  Product _product;
  get product => _product;
  set product(Product product) {
    _product = product;
    notifyListeners();
  }

  //push to detail
  Future pushToDetail(int index) async {
    await _navigationService.navigateWithTransition(
        ProductDetailView(
          index: index,
          product: product,
        ),
        duration: fastDurationTransition,
        transition: 'rightToLeft');
  }
}
