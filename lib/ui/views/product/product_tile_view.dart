import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/viewmodels/product/product_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductTileView extends StatelessWidget {
  final Product product;
  final int index;
  ProductTileView({this.product, this.index});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductTileViewModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        child: Hero(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xeeeeee),
                image: DecorationImage(
                  image: AssetImage(
                      ('assets/images/products/' + product.idProduct + '.png')),
                  fit: BoxFit.fill,
                )),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          ),
          tag: "pp$index",
        ),
        onTap: () async {
          await model.pushToDetail(index);
        },
      ),
      viewModelBuilder: () => ProductTileViewModel(),
      onModelReady: (model) => model.product = product,
    );
  }
}
