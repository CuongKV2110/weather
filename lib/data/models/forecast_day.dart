import 'package:json_annotation/json_annotation.dart';

import 'astro.dart';
import 'day.dart';
import 'hour.dart';

part 'forecast_day.g.dart';
@JsonSerializable()
class ForecastDay {

  DateTime date;
  @JsonKey(name: "date_epoch")
  int dateEpoch;
  Day day;
  Astro astro;
  List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);

}