import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/auth_toggle_state.dart';
import 'package:firecek_stacked_architecture/services/biometric_service.dart';
import 'package:firecek_stacked_architecture/services/connectivity_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/realtime_db_service.dart';
import 'package:firecek_stacked_architecture/services/secure_storage_service.dart';
import 'package:firecek_stacked_architecture/services/local_storage_service.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/myproduct_viewmodel.dart';
import 'package:firecek_stacked_architecture/viewmodels/menuhome/profile_viewmodel.dart';
import 'package:firecek_stacked_architecture/viewmodels/myproduct/watertank_monitoring_tile_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setupLocator() async {
  //service
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
  //view model
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => MyProductViewModel());
  locator.registerLazySingleton(() => WaterTankMonitoringTileViewModel());
}