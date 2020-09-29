import 'package:firecek_stacked_architecture/app/router.gr.dart';
import 'package:firecek_stacked_architecture/viewmodels/wrapper_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_helper.dart';

void main() {
  group('wrapper_viewmodel_test -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    group('handleStartUpLogic -', () {
      test(
          'When handleStartUpLogic started should run isUserLoggedIn on AuthService',
          () async {
        //if want to test signin true/false just change parameter
        // default is true

        var authService = getAndRegisterAuthServiceMock(isSignIn: false);
        var wrapperViewModel = WrapperViewModel();
        await wrapperViewModel.handleStartUpLogic();
        verify(authService.isUserLoggedIn());
      });

      test(
          'When handleStartUpLogic called and hasLoggedInUser returns true, should call replaceWith Routes.homeViewRoute',
          () async {
        var navigationService = getAndRegisterNavigationServiceMock();
        //if want to test signin true/false just change parameter
        // default is true
        getAndRegisterAuthServiceMock(isSignIn: true);
        var model = WrapperViewModel();
        //change the getAndRegisterAuthServiceMock parameter for different result
        //more info look at test_helper
        await model.handleStartUpLogic();
        verify(navigationService.replaceWith(Routes.homeViewRoute));
      });
    });
  });
}
