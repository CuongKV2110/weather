
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherUsecase{
  WeatherRepository _weatherRepository = WeatherRepository();
  GetData(){
    return _weatherRepository.GetData();
  }

}