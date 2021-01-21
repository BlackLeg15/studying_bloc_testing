import 'package:flutter/cupertino.dart';

import '../model/weather.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

class InitialState extends WeatherState {
  const InitialState();
}

class LoadingState extends WeatherState {
  const LoadingState();
}

class LoadedState extends WeatherState {
  final Weather weather;

  const LoadedState(this.weather);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoadedState && o.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}

class ErrorState extends WeatherState {
  final String message;

  const ErrorState(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ErrorState && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
