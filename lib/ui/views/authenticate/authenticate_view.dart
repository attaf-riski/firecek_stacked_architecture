import 'package:firecek_stacked_architecture/shared/no_conn.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/signin_view.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import '../../../viewmodels/authenticate/authenticate_viewmodel.dart';
import 'package:animations/animations.dart';

class AuthenticateView extends StatelessWidget {
  AuthenticateView({Key key}) : super(key: key);
  //refresh controller
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticateViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          body: SmartRefresher(
            child: (model.isOffline)
                ? LottieMessage()
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: SizedBox(
                          child: Center(
                            child: PageTransitionSwitcher(
                              duration: const Duration(milliseconds: 1500),
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
                                  transitionType:
                                      SharedAxisTransitionType.horizontal,
                                );
                              },
                              child: (model.isSignIn)
                                  ? SignInView()
                                  : SignUpView(),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                            model.toChangeView();
                          },
                          child: (model.isSignIn)
                              ? Text("Doesn't have account? Click Here!")
                              : Text("Back To Sign In")),
                      Visibility(
                        child: FlatButton(
                            onPressed: () {}, child: Text('Forget Password? ')),
                        visible: model.isSignIn,
                      )
                    ],
                  ),
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: () async {
              model.notifyListeners();
              await Future.delayed(Duration(seconds: 1));
              _refreshController.refreshCompleted();
            },
          ),
          resizeToAvoidBottomInset: true,
        ),
        onWillPop: model.backButton,
      ),
      viewModelBuilder: () => AuthenticateViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}
