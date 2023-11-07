import 'package:card_board/home/controller/home_store.dart';
import 'package:card_board/login/controller/login_store.dart';
import 'package:card_board/services/preference_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<PreferenceService>(
    PreferenceService(getIt()),
  );

  getIt.registerFactory<HomeStore>(() => HomeStore());
  getIt.registerFactory<LoginStore>(() => LoginStore());
}
