import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherUsecase {
  WeatherRepository _weatherRepository;
  WeatherUsecase(this._weatherRepository);
  getData() {
    return _weatherRepository.getData();
  }
}
