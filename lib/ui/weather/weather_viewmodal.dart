import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/services/weather_service.dart';
import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/weather_model.dart';
import '../../presentation/my_flutter_app_icons.dart';

class WeatherViewModel extends BaseViewModel {
  WeatherService weatherService = WeatherService();
  Welcome? weather;
  Position? position;
  double lat = 0, lon = 0;

  WeatherViewModel() {
    if (kDebugMode) {
      print("In Weather View Model");
    }
    fetchPosition();
  }

  Future<void> fetchPosition() async {
    if (kDebugMode) {
      print("In fetch position");
    }

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location Service is Disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Permission Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission Denied Forever');
      openAppSettings();
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    position = currentPosition;

    if (kDebugMode) {
      print(position);
    }
    lat = position!.latitude;
    lon = position!.longitude;
    if (lat != 0 && lon != 0) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (kDebugMode) {
      print("In fetch data");
    }
    try {
      weather = await weatherService.getWeather(lat: lat, lon: lon);
      rebuildUi();
      if (kDebugMode) {
        print("SUCCESS");
      }
    } catch (e) {
      if (kDebugMode) {
        print('API call error: $e');
      }
    }
  }

  IconData mapWeatherIcon(String icon) {
    final isDayIcon = icon.endsWith('d');

    switch (icon) {
      case '01d':
        return CustomIcons.icon01d;
      case '01n':
        return CustomIcons.icon01n;
      case '02d':
        return CustomIcons.icon02d;
      case '02n':
        return CustomIcons.icon02n;
      case '03d':
        return CustomIcons.icon03d;
      case '03n':
        return CustomIcons.icon03n;
      case '04d':
        return CustomIcons.icon04d;
      case '04n':
        return CustomIcons.icon04n;
      case '09d':
        return CustomIcons.icon09d;
      case '09n':
        return CustomIcons.icon09n;
      case '10d':
        return CustomIcons.icon10d;
      case '10n':
        return CustomIcons.icon10n;
      case '11d':
        return CustomIcons.icon11d;
      case '11n':
        return CustomIcons.icon11n;
      case '13d':
        return CustomIcons.icon13d;
      case '13n':
        return CustomIcons.icon13n;
      default:
        return isDayIcon ? CustomIcons.icon01d : CustomIcons.icon01n;
    }
  }
}
