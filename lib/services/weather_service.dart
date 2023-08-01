import 'package:dio/dio.dart';
import '../constants/app_url.dart';
import '../constants/constants.dart';
import '../models/weather_model.dart';
import '../utils/dio_client.dart';

class WeatherService {
  final dio = DioClient.dio;
  Future<Welcome> getWeather({required double lat, required double lon}) async {
    print("in service");
    late Welcome weather;
    try {
      Response userData = await dio.get(baseUrl,
          queryParameters: {'lat': lat, 'lon': lon, 'appid': apiKey});

      print("Location Data Is : $userData");
      weather = Welcome.fromJson(userData.data);
    } on DioException catch (e) {
      print(e);
    }
    return weather;
  }
}
