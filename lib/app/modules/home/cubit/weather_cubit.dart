import 'package:bloc/bloc.dart';
import 'package:studying_bloc_cubit/app/modules/home/model/weather.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitialState());

  void getWeather(String cityName) {
    emit(LoadingState());
    Future.delayed(Duration(seconds: 5)).then((value) {
      emit(LoadedState(Weather(cityName, 25.5)));
    }).catchError((e) {
      emit(ErrorState("Refutado, otário"));
    });
  }
}
