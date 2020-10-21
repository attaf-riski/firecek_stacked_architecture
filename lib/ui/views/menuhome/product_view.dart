import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/ui/views/product/product_tile_view.dart';
import 'package:firecek_stacked_architecture/ui/widgets/material_inkwell.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatelessWidget {
  //refresh controller
  final RefreshController _refreshController = RefreshController();

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
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: SmartRefresher(
                    controller: _refreshController,
                    child: ListView(
                      children: [
                        SizedBox(
                          child: Center(
                              child: Text(
                            'Product List',
                            style: textStyleButton,
                          )),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                        ),
                        MaterialInkwell(
                          backgroundColor: Color(0x2196f3),
                          borderRadiusValue: 15,
                          child: Opacity(
                            child: SizedBox(
                              child: Image(
                                image: AssetImage(
                                    'assets/images/products/qr_pairing.png'),
                                fit: BoxFit.fill,
                              ),
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                            ),
                            opacity: 0.8,
                          ),
                          onTap: () async {
                            await model.scanToAdd();
                          },
                          splashColor: Color(0xffbbdefa),
                        ),
                        GridView.count(
                            childAspectRatio: 3 / 2.3,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children: List.generate(
                                model.products.length ?? 0,
                                (index) => ProductTileView(
                                      product: model.products[index],
                                      index: index,
                                    ))),
                      ],
                    ),
                    enablePullDown: true,
                    onRefresh: () async {
                      model.notifyListeners();
                      await Future.delayed(Duration(seconds: 1));
                      _refreshController.refreshCompleted();
                    },
                  ),
                ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (model) => model.listenToProductList(),
      viewModelBuilder: () => ProductViewModel(),
    );
  }
}
