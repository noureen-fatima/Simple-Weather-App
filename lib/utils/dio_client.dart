import 'package:dio/dio.dart';
import '../constants/app_url.dart';
import '../constants/constants.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: connectionTimeout),
    receiveTimeout: const Duration(seconds: receiveTimeout),
    contentType: Headers.jsonContentType,
  );

  static Dio get dio => Dio(options);
}
