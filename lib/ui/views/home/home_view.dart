import 'package:animations/animations.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/viewmodels/home/home_viewmodel.dart';
import 'package:firecek_stacked_architecture/ui/views/menuhome/myproduct_view.dart';
import 'package:firecek_stacked_architecture/ui/views/menuhome/product_view.dart';
import 'package:firecek_stacked_architecture/ui/views/menuhome/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

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
        child: Scaffold(
          body: SmartRefresher(
            child: (model.isOffline)
                ? Column(
                    children: [
                      LottieMessage(
                        lottiePath: 'assets/lottie/no_conn.json',
                        title: 'No internet.',
                        height: MediaQuery.of(context).size.height * 0.5,
                      )
                    ],
                  )
                : PageTransitionSwitcher(
                    duration: slowDurationTransition,
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
                    child: getViewForIndex(model.index),
                  ),
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: () async {
              model.notifyListeners();
              await Future.delayed(Duration(seconds: 1));
              _refreshController.refreshCompleted();
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.lightBlue,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black38,
            currentIndex: model.index,
            onTap: model.setIndex,
            items: [
              BottomNavigationBarItem(
                label: 'Products',
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: 'My Products',
                icon: Icon(
                  Icons.storage,
                  size: 40,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        onWillPop: model.backButton,
      ),
      onModelReady: (model) async {
        if (isCheckBiometric) {
          await model.biometricPopUp(
              emailFromAuthenticate: emailFromAuthenticate,
              passwordFromAuthenticate: passwordFromAuthenticate);
        }
      },
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
