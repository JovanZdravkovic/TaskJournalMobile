import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';


class BaseService {

  final Dio dio;
  late CookieJar cookieJar;
<<<<<<< Updated upstream
  static const String baseUrl = 'https://taskjournal.online/api/';
=======
  static const String baseUrl = 'http://192.168.88.132:8080/';
>>>>>>> Stashed changes

  BaseService({ required this.dio }) {
    init();
  }

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final cookiesPath = '${directory.path}/cookies';

    final cookiesDir = Directory(cookiesPath);
    if (!cookiesDir.existsSync()) {
      cookiesDir.createSync(recursive: true);
    }

    cookieJar = PersistCookieJar(storage: FileStorage(cookiesPath));
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Response> get(String url, [Map<String, dynamic>? queryParams]) async {
    final response = await dio.get(baseUrl + url, queryParameters: queryParams);
    return response;
  }

  Future<Response> getRaw(String url, [Map<String, dynamic>? queryParams]) async {
    final response = await dio.get(
      baseUrl + url,
      queryParameters: queryParams,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return response;
  }

  Future<Response> post(String url, [Map<String, dynamic>? body]) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await dio.post(
      baseUrl + url,
      data: body,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }

  Future<Response> postMultipart(String url, FormData data) async {
    final headers = <String, String>{
      'Content-Type': 'multipart/form-data;',
    };
    final response = await dio.post(
      baseUrl + url,
      data: data,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }

  Future<Response> put(String url, [Map<String, dynamic>? body]) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await dio.put(
      baseUrl + url,
      data: body,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }
  
  Future<Response> delete(String url) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await dio.delete(
      baseUrl + url,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }
}