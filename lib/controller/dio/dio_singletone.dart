import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;
  final String baseUrl = "https://api.climbing-answer.com";
  final String baseUrlDev = "http://54.180.20.255";
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }
//http://flash-application-dev-env.eba-q2es2zy8.ap-northeast-2.elasticbeanstalk.com
  DioClient._internal() {
    print("dio 생성");
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );
  }
  void updateOptions({required String token}) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Dio get dio => _dio;
}
