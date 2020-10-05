import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel {
  FirestoreService _firestoreService = locator<FirestoreService>();

  List<Product> _products;
  get products => _products;
  set products(List<Product> products) => _products;

  void listenToProductList() async {
    setBusy(true);
    _firestoreService.listenToProductListRealTime().listen((result) {
      _products = result;
      notifyListeners();
    });
    setBusy(false);
  }
}
