import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_kiojuprivat/data/datasources/nbu_rates_api.dart';
import 'package:test_project_kiojuprivat/data/repositories/app_settings_repository_impl.dart';
import 'package:test_project_kiojuprivat/data/repositories/nbu_rates_repository.dart';
import 'package:test_project_kiojuprivat/data/storage/key_value_store.dart';
import 'package:test_project_kiojuprivat/data/storage/shared_preferences_store.dart';
import 'package:test_project_kiojuprivat/domain/repositories/app_settings_repository.dart';
import 'package:test_project_kiojuprivat/domain/repositories/rates_repository.dart';
import 'package:test_project_kiojuprivat/app/routing/app_router.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rate_history/rate_history_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rates/rates_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/settings/settings_bloc.dart';



final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // core
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  final sharedPrefs = await SharedPreferences.getInstance();
  locator.registerSingleton<KeyValueStore>(SharedPreferencesStore(sharedPrefs));

  // data
  locator.registerLazySingleton<NbuRatesApi>(
    () => NbuRatesApi(locator<Dio>()),
  );

  locator.registerLazySingleton<RatesRepository>(
    () => NbuRatesRepository(locator<NbuRatesApi>()),
  );

  locator.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(locator<KeyValueStore>()),
  );

  // Load initial settings before the app renders.
  final initialSettings = await locator<AppSettingsRepository>().load();

  // router
  locator.registerLazySingleton<GoRouter>(createAppRouter);

  // blocs
  locator.registerFactory<RatesBloc>(
    () => RatesBloc(repository: locator<RatesRepository>()),
  );

  locator.registerFactory<RateHistoryBloc>(
    () => RateHistoryBloc(repository: locator<RatesRepository>()),
  );

  locator.registerSingleton<SettingsBloc>(
    SettingsBloc(
      repository: locator<AppSettingsRepository>(),
      initialSettings: initialSettings,
    ),
  );
}
