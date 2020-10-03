import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/ui/views/product/product_tile_view.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      builder: (context, model, child) => (model.isBusy)
          ? Loading()
          : (model.products == null)
              ? LottieMessage(
                  lottiePath: 'assets/lottie/empty.json',
                  title: 'No Products',
                )
              : Container(
                  margin: EdgeInsets.all(20),
                  child: GridView.count(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 3,
                      children: List.generate(
                          model.products.length ?? 0,
                          (index) => ProductTileView(
                                product: model.products[index],
                                index: index,
                              ))),
                ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (model) => model.listenToProductList(),
      viewModelBuilder: () => locator<ProductViewModel>(),
    );
  }
}
