import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:weather/data/models/weather.dart';
class WeatherProvider {
  late Dio _dio;
  WeatherProvider() {
    _dio = Dio()
      ..interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Future<Weather> getData() async {
    Response response = await _dio.get(
      "https://api.weatherapi.com/v1/forecast.json?key=208a345e6cd9449381540850222103&q=HaNoi&days=4&aqi=no&alerts=no",
    );
    return Weather.fromJson(response.data ?? "");
  }
}