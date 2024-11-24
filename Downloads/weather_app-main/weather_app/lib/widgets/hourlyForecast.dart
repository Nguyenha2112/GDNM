
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/provider/weatherProvider.dart';
import '../Screens/hourlyWeatherScreen.dart';
import '../helper/utils.dart';

class HourlyForecast extends StatelessWidget{
  Widget hourlyWidget(dynamic weather, BuildContext){
    final currentTime = weather.dtTxt;
    final hours = DateFormat.Hm().format(DateTime.parse(currentTime));
    
    return Container(
      height: 175,
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hours,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  MapString.mapStringToIcon(
                    '${weather.weather![0].main}',
                    50,
                  ),
                  Container(
                    width: 80,
                    child: Text(
                      "${weather.main.temp.toStringAsFixed(1)}°C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 Hours',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed(HourlyScreen.routeName);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
        Consumer<WeatherProvider>(builder: (context, weatherProv, _){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weatherProv.hourlyWeather.take(3)
                .map((item) => hourlyWidget(item, context))
                .toList(),
          );
        }),
      ],
    );
  }
}
