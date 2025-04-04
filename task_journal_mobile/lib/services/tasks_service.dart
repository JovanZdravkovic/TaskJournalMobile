import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class TasksService {

  final BaseService baseService;

  TasksService({ required this.baseService });
  
  List<Task> parseTasksJson(List<dynamic> jsonResponse) {
    final parsedList = jsonResponse.cast<Map<String, dynamic>>();
    return parsedList.map<Task>((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> getTasks() async {
    try {
      final response = await baseService.get('tasks');
      return parseTasksJson(response.data);
    } on DioException catch (e) {
      return [];
    }
  }
}