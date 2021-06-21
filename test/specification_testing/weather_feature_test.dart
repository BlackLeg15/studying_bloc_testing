import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:studying_bloc_cubit/app/modules/home/bloc/weather_bloc.dart';
import 'package:studying_bloc_cubit/app/modules/home/model/weather.dart';

class WeatherBlocMock extends MockBloc<WeatherEvent, WeatherState> implements WeatherBloc {}

main() {
  late WeatherBlocMock weatherBloc;
  const loadedWeather = const Weather('Jardim de Piranhas', 19.9);
  setUpAll(() {
    registerFallbackValue<WeatherEvent>(const GetWeather('Jardim de Piranhas'));
    registerFallbackValue<WeatherState>(const LoadedState(loadedWeather));
  });

  test('Apenas um teste inicial', () async {
    weatherBloc = WeatherBlocMock();
    whenListen(
      weatherBloc,
      Stream.fromIterable(
        [
          const LoadingState(),
          const LoadedState(loadedWeather)
        ],
      ),
    );
    //expect(weatherBloc.state, isA<InitialState>());
    await expectLater(
      weatherBloc.stream,
      emitsInOrder(
        <WeatherState>[
          const LoadingState(),
          const LoadedState(loadedWeather)
        ],
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
      blocTest<WeatherBloc, WeatherState>(
        '1. A partir de uma string vazia, retorna erro',
        build: () => WeatherBloc(),
        act: (bloc) => bloc.add(GetWeather('')),
        expect: () => [
          isA<LoadingState>(),
          ErrorState('Erro: Campo nome da cidade não foi preenchido')
        ],
      );
      blocTest<WeatherBloc, WeatherState>(
        '2. A partir de uma string nula, retorna erro',
        build: () => WeatherBloc(),
        act: (bloc) => bloc.add(GetWeather(null)),
        expect: () => [
          isA<LoadingState>(),
          ErrorState('Erro: Campo nome da cidade não foi preenchido')
        ],
      );
      blocTest<WeatherBloc, WeatherState>(
        '3. A partir de uma string válida, retorna temperatura',
        build: () => WeatherBloc(),
        act: (bloc) => bloc.add(GetWeather('Jardim')),
        expect: () => [
          isA<LoadingState>(),
          LoadedState(Weather('Jardim', 19.9))
        ],
      );
    },
  );
}
