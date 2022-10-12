// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/constant/colors.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        toolbarHeight: Adaptive.h(10),
        elevation: 0,
        actions: [
          IconButton(
            iconSize: Adaptive.w(7),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Weatherex',
          style: TextStyle(
              fontSize: Adaptive.w(7),
              fontWeight: FontWeight.bold,
              color: myColors.myblack),
        ),
      ),
      body: Center(
        child: Container(
          height: Adaptive.w(10),
          width: Adaptive.w(90),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onChanged: (data) {
                cityName = data;
              },
              onSubmitted: (data) async {
                cityName = data;
                BlocProvider.of<WeatherCubit>(context)
                    .getWeather(cityName: cityName!);
                BlocProvider.of<WeatherCubit>(context).cityName = cityName;
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                prefixIcon: Icon(Icons.search, size: Adaptive.w(6),),
                prefixIconColor: Colors.grey,
                border: InputBorder.none,
                hintText: ' Search City',
                hintStyle: TextStyle(fontSize: Adaptive.w(4))
              ),
              showCursor: false,
              autofocus: true,
              style: TextStyle(fontSize: Adaptive.w(4)),
            ),
          ),
        ),
      ),
    );
  }
}
