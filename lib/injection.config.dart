// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/repositories/weather_repository.dart' as _i3;
import 'domain/usecases/weather_usecase.dart' as _i4;
import 'presentation/home/bloc/cubit/weather_cubit.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.WeatherRepository>(() => _i3.WeatherRepository());
  gh.factory<_i4.WeatherUsecase>(
      () => _i4.WeatherUsecase(get<_i3.WeatherRepository>()));
  gh.factory<_i5.WeatherCubit>(
      () => _i5.WeatherCubit(get<_i4.WeatherUsecase>()));
  return get;
}
