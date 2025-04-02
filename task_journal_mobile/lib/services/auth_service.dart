import 'package:dio/dio.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class AuthService {

  final BaseService baseService;

  AuthService({ required this.baseService });

  Future<bool> authenticate() async {
    try {
      await baseService.get('auth');
      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> login(Map<String, dynamic> credentials) async {
    try {
      await baseService.post('login', credentials);
      return true;
    } on DioException catch (e) {
      return false;
    }
  }
}