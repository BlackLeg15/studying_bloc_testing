import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studying_bloc_cubit/app/modules/home/bloc/weather_bloc.dart';
import 'package:studying_bloc_cubit/app/modules/home/model/weather.dart';

class WeatherBlocMock extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

main() {
  var weatherBloc;
  const loadedWeather = const Weather('Jardim de Piranhas', 19.9);
  setUpAll(() {
    weatherBloc = WeatherBlocMock();
  });
  group(
    'Testa o caso de uso: Retornar uma temperatura a partir do nome de uma cidade',
    () {
      test('A partir de uma string vazia, não retorna nada', () async {
        whenListen(
            weatherBloc,
            Stream.fromIterable(
              [const LoadingState(), const LoadedState(loadedWeather)],
            ));
        //expect(weatherBloc.state, isA<WeatherInitial>());
        await expectLater(
          weatherBloc,
          emitsInOrder(
            <WeatherState>[
              const LoadingState(),
              const LoadedState(loadedWeather)
            ],
          ),
        );
        //expect(weatherBloc.state, isA<LoadedState>());
      });
      test('A partir de um null, não retorna nada', () {});
    },
  );
}
