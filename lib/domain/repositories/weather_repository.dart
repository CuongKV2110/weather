import 'package:dio/dio.dart';
import 'package:weather/data/retrofit/api_client.dart';

class WeatherRepository {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

  getData() {
    return client.getWeather();
  }
}
