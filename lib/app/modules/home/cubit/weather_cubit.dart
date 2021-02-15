import 'package:bloc/bloc.dart';
import 'package:studying_bloc_cubit/app/modules/home/model/weather.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitialState());

  void getWeather(String cityName) async {
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 5));
    if (cityName.isEmpty)
      emit(ErrorState('Erro: Campo nome da cidade não foi preenchido'));
    else
      emit(LoadedState(Weather(cityName, 25.5)));
  }
}
