import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';


class BaseService {

  final Dio dio;
  late CookieJar cookieJar;

  BaseService({ required this.dio }) {
    init();
  }

  void init() {
    cookieJar = PersistCookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Response> get(String url) async {
    final response = await dio.get(url);
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> body) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await dio.post(
      url,
      data: body,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }

  Future<Response> put(String url, Map<String, dynamic> body) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await dio.put(
      url,
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
      url,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }
}