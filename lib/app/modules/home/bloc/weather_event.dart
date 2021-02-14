part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final cityName;
  const GetWeather(this.cityName);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GetWeather && o.cityName == cityName;
  }

  @override
  int get hashCode => cityName.hashCode;
}
