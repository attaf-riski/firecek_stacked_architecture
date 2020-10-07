import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:firecek_stacked_architecture/services/barcode_service.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/cloud_storage_service.dart';
import 'package:firecek_stacked_architecture/services/connectivity_service.dart';
import 'package:firecek_stacked_architecture/services/fcm_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/home_index_service.dart';
import 'package:firecek_stacked_architecture/services/media_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/menu_home_viewmodel.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/product_viewmodel.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/menu_profile_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  //service
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthToggleState());
  locator.registerLazySingleton(() => BiometricService());
  var instanceSecureStorageService = await SecureStorageService.getInstance();
  locator.registerLazySingleton<SecureStorageService>(
      () => instanceSecureStorageService);
  locator.registerLazySingleton(() => ConnectivityService());
  var instanceLocalStorageService = await LocalStorageService.getInstance();
  locator.registerLazySingleton<LocalStorageService>(
      () => instanceLocalStorageService);
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => RealtimeDBService());
  locator.registerLazySingleton(() => BarcodeService());
  locator.registerLazySingleton(() => HomeIndexService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => MediaService());
  //view model
  locator.registerLazySingleton(() => MenuHomeViewModel());
  locator.registerLazySingleton(() => ProductViewModel());
  locator.registerLazySingleton(() => MenuProfileViewModel());
}
