
import 'dart:typed_data';

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

  Future<Uint8List?> getIcon() async {
    try {
      final response = await baseService.getRaw("user/icon");
      final result = Uint8List.fromList(response.data);
      return result;
    } catch (_) {
      return null;
    }
  }

}