import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';

class HourlyScreen extends StatelessWidget {
  static const routeName = '/hourlyScreen';

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final time = weather.dtTxt;
    final hours = DateFormat('dd-MM-yyyy hh:00').format(DateTime.parse(time));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Material(
        elevation: 5,
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                hours,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Text(
                '${weather.main.temp.toStringAsFixed(1)}°',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16.0),
              MapString.mapStringToIcon(weather.weather[0].main, 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Forecast of 5 days In 3 Hours',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: weatherData.hourly24Weather
                .map((item) => dailyWidget(item, context))
                .toList(),
          ),
        ),
      ),
    );
  }
}
