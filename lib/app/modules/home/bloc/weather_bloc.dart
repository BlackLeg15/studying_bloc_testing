import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const InitialState());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield const LoadingState();
    if (event is GetWeather) {
      await Future.delayed(Duration(seconds: 2));
      if (event.cityName == null || event.cityName!.isEmpty) {
        yield ErrorState('Erro: Campo nome da cidade não foi preenchido');
      } else {
        yield LoadedState(Weather(event.cityName!, 19.9));
      }
    }
  }
}
