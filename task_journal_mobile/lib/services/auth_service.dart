import 'package:dio/dio.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class AuthService {

  final BaseService baseService;

  AuthService({ required this.baseService });

  Future<bool> authenticate() async {
    try {
      await baseService.get('auth');
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> login(Map<String, dynamic> credentials) async {
    try {
      await baseService.post('login', credentials);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, String>> signup(Map<String, dynamic> credentials) async {
    try {
      final response = await baseService.post('signup', credentials);
      final id = response.data['id'];
      return {
        'id': id,
      };
    } catch (e) {
      if(e is DioException && e.response?.data != null) {
        return {
          'error': e.response?.data
        };
      }
      return {
        'error': 'error while signing up',
      };
    }
  }
}