import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/datasources/provider/weather_provider.dart';
import 'package:weather/data/models/weather.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final WeatherProvider _weatherProvider = WeatherProvider();
  AppBloc() : super(Initial());
  Weather? weather; // ? la co the nhan gia tri null

  void dispose() {
    close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GetData) {
      print("GetData in Bloc");
      yield Loading();
      //await Future.delayed(const Duration(milliseconds: 1500), () {});
      weather = await _weatherProvider.getData();
      if (weather != null) {
        yield Loaded();
      } else {
        yield Error(errorMessage: 'Loi');
      }
    }
  }
}
