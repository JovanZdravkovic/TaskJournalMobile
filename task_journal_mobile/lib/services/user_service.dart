
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:task_journal_mobile/models/user.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class UserService {

  final BaseService baseService;

  UserService({ required this.baseService });

  Future<User?> getUser() async {
    try {
      final response = await baseService.get("user");
      final result = User.fromJson(response.data);
      return result;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, String>> updateUser(Map<String, dynamic> userData) async {
    try {
      final response = await baseService.put("user", userData);
      final result = response.data['success'];
      if(result) {
        return {
          'success': 'Successfully updated user'
        };
      } else {
        return {
          'error': 'Error while updating user'
        };
      }
    } catch (e) {
      if(e is DioException && e.response?.data != null) {
        return {
          'error': e.response!.data
        };
      } else {
        return {
          'error': 'Error while updating user'
        };
      }
    }
  }

  Future<Uint8List?> getIcon() async {
    try {
      final response = await baseService.getRaw("user/icon");
      final result = Uint8List.fromList(response.data);
      return result;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, String>> uploadIcon(FormData formData) async {
    try {
      final response = await baseService.postMultipart("user/icon", formData);
      final result = response.data['success'];
      if(result) {
        return {
          'success': 'Successfully uploaded icon'
        };
      } else {
        return {
          'error': 'Error while uploading icon'
        };
      }
    } catch (e) {
      if(e is DioException && e.response?.data != null) {
        return {
          'error': e.response!.data
        };
      } else {
        return {
          'error': 'Error while uploading icon'
        };
      }
    }
  }

}