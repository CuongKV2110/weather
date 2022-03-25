import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather/data/models/weather.dart';
import 'apis.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.weatherapi.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.weather)
  Future<Weather> getWeather();
}
