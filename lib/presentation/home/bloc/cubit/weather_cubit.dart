import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/usecases/weather_usecase.dart';
import 'package:weather/presentation/home/bloc/cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherUsecase) : super(WeatherInitial());
  WeatherUsecase weatherUsecase;

  Future<void> getWeather() async {
    print("getWeather()");
    emit(WeatherLoading());
    var resWeather = await weatherUsecase.getData();
    if (resWeather != null) {
      emit(WeatherLoaded(resWeather));
    } else {
      emit(WeatherError());
    }
  }
}
