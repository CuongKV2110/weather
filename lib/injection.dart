import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/weather_usecase.dart';
import 'package:weather/presentation/bloc/cubit/weather_cubit.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await $initGetIt(getIt);

  getIt.registerSingleton<WeatherRepository>(WeatherRepository());
  getIt.registerSingleton<WeatherUsecase>(WeatherUsecase(getIt()));
  getIt.registerFactory<WeatherCubit>(() => WeatherCubit(getIt()));
}
