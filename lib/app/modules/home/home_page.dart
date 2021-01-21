import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'bloc/weather_bloc.dart';
import 'cubit/weather_cubit.dart';
import 'cubit/weather_state.dart';
import 'model/weather.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studying Bloc & Cubit"),
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          //child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is InitialState) {
              return buildInitialInput();
            } else if (state is LoadedState)
              return buildColumnWithData(state.weather);
            else if (state is LoadingState)
              return CircularProgressIndicator();
            else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() => Center(
        child: CityInputField(),
      );
  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureInCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

void submitCityName(BuildContext context, String cityName) {
  final cubit = BlocProvider.of<WeatherCubit>(context);
  cubit.getWeather(cityName);
  //final bloc = BlocProvider.of<WeatherBloc>(context);
  //bloc.add(GetWeather(cityName));
  //bloc.close();
}

var cityName = '';

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        key: Key("city-field"),
        maxLength: 5,
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        onChanged: (value) => cityName = value,
        decoration: InputDecoration(
          hintText: "Digite o nome de uma cidade",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: InkWell(
            key: Key('submit'),
            child: Icon(Icons.search),
            onTap: () => submitCityName(context, cityName),
          ),
        ),
      ),
    );
  }
}
