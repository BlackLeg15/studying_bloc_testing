import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studying_bloc_cubit/app/modules/home/bloc/weather_bloc.dart';
import 'package:studying_bloc_cubit/app/modules/home/model/weather.dart';

class WeatherBlocMock extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

main() {
  var weatherBloc;
  var loadedWeather = Weather('Jardim de Piranhas', 19.9);
  setUpAll(() {
    weatherBloc = WeatherBlocMock();
  });

  test('Apenas um teste inicial', () async {
    whenListen(
        weatherBloc,
        Stream.fromIterable(
          [const LoadingState(), LoadedState(loadedWeather)],
        ));
    //expect(weatherBloc.state, isA<InitialState>());
    await expectLater(
      weatherBloc,
      emitsInOrder(
        <WeatherState>[const LoadingState(), LoadedState(loadedWeather)],
      ),
    );
    //expect(weatherBloc.state, isA<LoadedState>());
  });
  group(
    'Caso de uso: Retornar uma temperatura a partir do nome de uma cidade',
    () {
      blocTest(
        '0. Teste do estado inicial',
        build: () => WeatherBloc(),
        expect: () => [],
      );
      blocTest(
        '1. A partir de uma string vazia, retorna erro',
        build: () => WeatherBloc(),
        act: (WeatherBloc bloc) {
          (bloc).add(GetWeather(''));
        },
        expect: () => [
          isA<LoadingState>(),
          ErrorState('Erro: Campo nome da cidade não foi preenchido')
        ],
      );
      blocTest(
        '2. A partir de uma string nula, retorna erro',
        build: () => WeatherBloc(),
        act: (WeatherBloc bloc) {
          (bloc).add(GetWeather(null));
        },
        expect: () => [
          isA<LoadingState>(),
          ErrorState('Erro: Campo nome da cidade não foi preenchido')
        ],
      );
    },
  );
}
