import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthServiceMock extends Mock implements AuthService {}

class NavigationServiceMock extends Mock implements NavigationService {}

AuthService getAndRegisterAuthServiceMock({bool isSignIn = true}) {
  _removeRegistrationIfExists<AuthService>();

  var service = AuthServiceMock();

  // stubbing
  when(service.isUserLoggedIn()).thenAnswer((realInvocation) {
    if (isSignIn) {
      return Future.value(true);
    }
    return Future.value(false);
  });

  locator.registerLazySingleton<AuthService>(() => service);
  return service;
}

NavigationService getAndRegisterNavigationServiceMock() {
  _removeRegistrationIfExists<NavigationService>();
  var service = NavigationServiceMock();
  locator.registerLazySingleton<NavigationService>(() => service);
  return service;
}

void registerServices() {
  getAndRegisterAuthServiceMock();
  getAndRegisterNavigationServiceMock();
}

void unregisterServices() {
  locator.unregister<AuthService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

//hal yang perlu diperhatikan
//bila dalam sebuah viewmodel terdapat service
//maka harus di daftarkan semua servicenya
//di file ini
