import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../models/dailyWeather.dart';
import '../models/weather.dart';

class WeatherProvider with ChangeNotifier{
  String apiKey = 'a1574d141f67b7aa2754e357a82eadab'; 

  LatLng? currentLocation;
  WeatherResponse? weather;
  DailyWeather currentWeather = DailyWeather();
  List<ListData> hourlyWeather = [];
  List<ListData> hourly24Weather = [];
  List<ListData> sevenDayWeather = [];
  Set<String> uniqueDaysSet = Set<String>();
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;
  bool serviceEnabled = false;
  LocationPermission? permission;

  Future<Position>? requestLocation(BuildContext context) async{
    serviceEnabled = await Geolocator.isLocationServiceEnabled();         
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location service disabled'),
      ));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();    // kiem tr quyen truy cap
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied'),
      ));
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherData(
    BuildContext context, {
    bool isRefresh = false,
    }) async {
      isLoading = true;
      isRequestError = false;
      isLocationError = false;
      if (isRefresh) notifyListeners();

      Position? locData = await requestLocation(context);
      if(locData == null){
        isLocationError = true;
        notifyListeners();
        return;
      }

      try{
        currentLocation = LatLng(locData.latitude, locData.longitude);
        await getCurrentWeather(currentLocation!);
        await getDailyWeather(currentLocation!);
      }catch(e){
        print(e);
        isLocationError = true;
      } finally {
        isLoading = false;
        notifyListeners();
      }
  }
  Future<void> getCurrentWeather(LatLng location) async{
      Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
      );
      try{
        final response = await http.get(url);     //gui yeu cau lay du lieu hien tai
        print(response.body);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        weather = WeatherResponse.fromJson(extractedData);
      }catch (error){
        print(error);
        isLoading = false;
        this.isRequestError = true;
      } finally{
        isLoading = false;
        notifyListeners();
      }
    }

    Future<void> getDailyWeather(LatLng location) async{
      isLoading = true;
      notifyListeners();

      Uri dailyUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&units=metric&lon=${location.longitude}&appid=${apiKey}',
      );
      try{
        final response = await http.get(dailyUrl);
        print("Daily response");
        inspect(response.body);
        print(response.body);
        final dailyData = json.decode(response.body) as Map<String, dynamic>;
        currentWeather = DailyWeather.fromJson(dailyData);
        hourlyWeather = currentWeather.list!;
        hourly24Weather = currentWeather.list!;
        for(var forecast in hourly24Weather){
          String date = forecast.dtTxt!.split(" ")[0];
          if (!uniqueDaysSet.contains(date)) {
            uniqueDaysSet.add(date);
            sevenDayWeather.add(forecast);
          }
        }
      }catch (error) {
        print(error);
        this.isRequestError = true;
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }

    Future<void> searchWeatherWithLocation(String location) async{
      Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey',
      );
      try{
        final response = await http.get(url);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        weather = WeatherResponse.fromJson(extractedData);
      }catch(error){
        print(error);
        this.isRequestError = true;
      }finally{
        isLoading = false;
        notifyListeners();
      }
    }

    Future<void> searchWeather(String location) async{
      isLoading = true;
      notifyListeners();
      isRequestError = false;
      isLocationError = false;
      await searchWeatherWithLocation(location);
      if(weather == null){
        isRequestError = true;
        notifyListeners();
        return;
      }
      await getDailyWeather(LatLng(
        weather!.coord!.lat!.toDouble(), weather!.coord!.lon!.toDouble()));
    }

    
}