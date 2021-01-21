import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/cubit/weather_cubit.dart';
import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Bloc + Cubit',
      theme: ThemeData(
        textSelectionHandleColor: Colors.grey,
      ),
      home: BlocProvider(
        child: HomePage(),
        create: (_) => WeatherCubit(),
        //create: (_) => WeatherBloc(),
      ),
    );
  }
}
