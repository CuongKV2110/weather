import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/models/weather.dart';

part 'weather_response.g.dart';
@JsonSerializable()
class WeatherResponse{
  final List<Weather> data;

  WeatherResponse(this.data);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJSON() => _$WeatherResponseToJson(this);

}
