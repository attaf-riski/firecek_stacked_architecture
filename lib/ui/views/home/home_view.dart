import 'package:firecek_stacked_architecture/ui/views/home/home_viewmodel.dart';
import 'package:firecek_stacked_architecture/ui/views/home/myproduct_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/product_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
            body: getViewForIndex(model.currentIndex),
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Column(
                  children: [Icon(Icons.ac_unit), Text('Product')],
                ),
                Column(
                  children: [Icon(Icons.ac_unit), Text('My Product')],
                ),
                Column(
                  children: [Icon(Icons.ac_unit), Text('My Profile')],
                )
              ],
              onTap: model.setIndex,
            )),
        viewModelBuilder: () => HomeViewModel());
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return ProductView();
      case 1:
        return MyProductView();
      default:
        return ProfileView();
    }
  }
}
