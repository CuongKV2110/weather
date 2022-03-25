import 'package:flutter/cupertino.dart';

abstract class AppState {}
@immutable

class Initial extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class Error extends AppState {
  late final String errorMessage;

  Error({required this.errorMessage});
}
