// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(BlocProvider(
      create: (context) {
        return WeatherCubit(WeatherService());
      },
      child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
           debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch:
                BlocProvider.of<WeatherCubit>(context).weatherModel == null
                    ? Colors.orange
                    : BlocProvider.of<WeatherCubit>(context)
                        .weatherModel!
                        .getThemeColor(),
          ),
          home: HomePage(),
        );
      },
    );
  }
}
