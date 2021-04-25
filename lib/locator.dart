import 'package:farmgate/locator.config.dart';
import 'package:farmgate/src/common/firebase_config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simplest/simplest.dart';

GetIt locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() => $initGetIt(locator);

@module
abstract class StackedServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
}

@module
abstract class SimplestServicesModule {
  @lazySingleton
  LocationService get locationService;
  @lazySingleton
  NetworkActivityService get networkActivityService;
  @preResolve
  Future<NotificationService> get notificationService =>
      NotificationService.init(isShowLocalNotification: true);
  @lazySingleton
  PhoneAuthService get phoneAuthService;
  @lazySingleton
  MediaService get mediaService;
}

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseConfig> get firebaseConfig => FirebaseConfig.init();
  @preResolve
  Future<AppPref> get appPrefs => AppPref.instance();
}
