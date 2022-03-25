import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/data/models/weather.dart';

@immutable
abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  WeatherInitial();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoading extends WeatherState {
  WeatherLoading();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded(this.weather);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherError extends WeatherState {
  WeatherError();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
