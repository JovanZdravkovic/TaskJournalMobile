import 'package:dio/dio.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class AuthService {

  final BaseService baseService;

  AuthService({ required this.baseService });

  Future<bool> authenticate() async {
    try {
      final response = await baseService.get('auth');
      print(response.data);
      return true;
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }
}