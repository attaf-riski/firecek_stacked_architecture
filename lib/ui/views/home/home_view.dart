import 'package:animations/animations.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/ui/widgets/statefull_wrapper.dart';
import 'package:firecek_stacked_architecture/viewmodels/home_viewmodel.dart';
import 'package:firecek_stacked_architecture/ui/views/home/myproduct_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/product_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeView extends StatelessWidget {
  final bool isCheckBiometric;
  final String emailFromAuthenticate;
  final String passwordFromAuthenticate;
  HomeView({
    this.emailFromAuthenticate,
    this.passwordFromAuthenticate,
    this.isCheckBiometric = false,
    Key key,
  }) : super(key: key);
  //refresh controller
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        child: StatefulWrapper(
          onInit: (isCheckBiometric)
              ? () async {
                  await model.biometricPopUp(
                      emailFromAuthenticate: emailFromAuthenticate,
                      passwordFromAuthenticate: passwordFromAuthenticate);
                }
              : null,
          child: Scaffold(
              body: SmartRefresher(
                child: PageTransitionSwitcher(
                  duration: durationTransition,
                  reverse: true,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                    );
                  },
                  child: getViewForIndex(model.currentIndex),
                ),
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  _refreshController.refreshCompleted();
                },
              ),
              bottomNavigationBar: CurvedNavigationBar(
                items: [
                  Column(
                    children: [Icon(Icons.list), Text('Product')],
                  ),
                  Column(
                    children: [Icon(Icons.storage), Text('My Product')],
                  ),
                  Column(
                    children: [Icon(Icons.person), Text('My Profile')],
                  )
                ],
                onTap: model.setIndex,
              )),
        ),
        onWillPop: model.backButton,
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
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
