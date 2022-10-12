// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footer/footer.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        } else if (state is WeatherSuccess) {
          weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
          return SuccessBody(weatherData: weatherData);
        } else if (state is WeatherFailure) {
          return FailureBody();
        } else {
          return InitialBody();
        }
      }),
    );
  }
}

class InitialBody extends StatelessWidget {
  const InitialBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: Adaptive.w(80),
        height: Adaptive.h(40),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(7, 7), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(60),
            color: Color.fromRGBO(255, 220, 218, 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Adaptive.w(20),
              height: Adaptive.w(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/error.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: Adaptive.w(6),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: Adaptive.w(6),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class FailureBody extends StatelessWidget {
  const FailureBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: Adaptive.w(80),
        height: Adaptive.h(40),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(7, 7), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(60),
            color: Color.fromRGBO(255, 220, 218, 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Adaptive.w(20),
              height: Adaptive.w(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/error.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: Adaptive.w(6),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: Adaptive.w(6),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  SuccessBody({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel? weatherData;
  static final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Adaptive.h(5),
          ),
          Text(
            DateFormat.yMMMMEEEEd('en_US').format(now),
            style: TextStyle(
                fontSize: Adaptive.w(3),
                fontWeight: FontWeight.w400,
                color: myColors.mygrey),
          ),
          SizedBox(
            height: Adaptive.h(10),
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!.toUpperCase(),
            style: TextStyle(
              color: myColors.myblack,
              fontSize: Adaptive.w(7),
              fontWeight: FontWeight.bold,
              letterSpacing: Adaptive.w(0.8),
            ),
          ),
          SizedBox(
            height: Adaptive.h(2),
          ),
          Text(
            weatherData!.weatherStateName.toUpperCase(),
            style: TextStyle(
                fontSize: Adaptive.w(4.5),
                letterSpacing: Adaptive.w(1),
                fontWeight: FontWeight.w400,
                color: myColors.mygrey),
          ),
          SizedBox(
            height: Adaptive.h(5),
          ),
          Image.asset(
            weatherData!.getImage(),
            width: Adaptive.h(8),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Adaptive.h(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weatherData!.temp.toInt().toString(),
                style: TextStyle(
                  color: myColors.myblack,
                  fontSize: Adaptive.w(20),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: Adaptive.w(2),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, Adaptive.w(10)),
                width: Adaptive.w(5),
                height: Adaptive.w(5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/degree.png'))),
              ),
            ],
          ),
          SizedBox(
            height: Adaptive.h(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'max',
                    style: TextStyle(
                        fontSize: Adaptive.w(5), color: myColors.mygrey),
                  ),
                  SizedBox(
                    height: Adaptive.w(2.5),
                  ),
                  Text(
                    '${weatherData!.maxTemp.toInt()}',
                    style: TextStyle(
                        fontSize: Adaptive.w(5),
                        color: myColors.mygrey,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                width: Adaptive.w(3),
              ),
              Container(
                width: Adaptive.w(0.3),
                color: myColors.mygrey,
                height: Adaptive.w(10),
              ),
              SizedBox(
                width: Adaptive.w(3),
              ),
              Column(
                children: [
                  Text(
                    'min',
                    style: TextStyle(
                        fontSize: Adaptive.w(5), color: myColors.mygrey),
                  ),
                  SizedBox(
                    height: Adaptive.w(2.5),
                  ),
                  Text(
                    '${weatherData!.minTemp.toInt()}',
                    style: TextStyle(
                        fontSize: Adaptive.w(5),
                        color: myColors.mygrey,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          Spacer(),
          Footer(
            padding: EdgeInsets.only(bottom: Adaptive.h(5)),
            backgroundColor: Colors.transparent,
            child: Text(
              'last updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
              style: TextStyle(
                fontSize: Adaptive.w(3),
                color: myColors.mygrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
