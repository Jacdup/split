import 'package:get_it/get_it.dart';
//import '../services/login_service.dart';
import '../services/localstorage_service.dart';

GetIt locator = GetIt.instance;
//GetIt getIt = GetIt.instance;

Future setupLocator() async {
//  locator.registerSingleton(UserService());
//  locator.registerFactory<LoginService>(() => LoginService());

  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
 // locator.registerSingleton(LocalStorageService());
}
