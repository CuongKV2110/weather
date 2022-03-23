import 'package:json_annotation/json_annotation.dart';

import 'forecast_day.dart';

part 'forecast.g.dart';
@JsonSerializable()
class Forecast {
  List<ForecastDay> forecastday;

  Forecast({
    required this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

}
