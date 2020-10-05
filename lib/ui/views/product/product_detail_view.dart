import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/viewmodels/product/product_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final int index;
  ProductDetailView({this.index, this.product});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                      onPressed: () => model.backButton()),
                ),
                SizedBox(
                  child: Hero(
                      tag: "pp$index",
                      child: Center(
                        child: SizedBox(
                          child: Image(
                            image: NetworkImage(product.imageURL),
                            fit: BoxFit.cover,
                          ),
                          height: 200,
                          width: 200,
                        ),
                      )),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        product.name,
                        style: welmo,
                      ),
                      verticalSpaceMedium,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description : ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          )),
                      SizedBox(
                        child: ListView(
                          children: [
                            Text(
                              product.description,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.32,
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "Add Product",
                              ),
                              onPressed: () async {
                                await model.scanToAdd();
                              })),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      color: Colors.blue),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            color: Colors.lightBlue[50],
          ),
          if (model.isBusy)
            Container(
              child: Loading(),
              color: Colors.lightBlue.withOpacity(0.4),
            )
        ]),
      ),
      viewModelBuilder: () => ProductDetailViewModel(),
    );
  }
}
