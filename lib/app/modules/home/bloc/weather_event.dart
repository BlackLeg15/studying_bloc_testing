part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final cityName;
  GetWeather(this.cityName);
}
