import 'dart:convert';

import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class TasksService {

  final BaseService baseService;

  TasksService({ required this.baseService });
  
  List<Task> parseTasksJson(List<dynamic> jsonResponse) {
    final parsedList = jsonResponse.cast<Map<String, dynamic>>();
    return parsedList.map<Task>((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> getTasks([Map<String, dynamic>? queryParams]) async {
    try {
      final response = await baseService.get('tasks', queryParams);
      final tasks = parseTasksJson(response.data);
      return tasks;
    } catch (_) {
      return [];
    }
  }

  Future<Task?> getTask(String taskId) async {
    try {
      final response = await baseService.get('task/$taskId');
      final task = Task.fromJson(response.data);
      return task;
    } catch(_) {
      return null;
    }
  }

  Future<bool> completeTask(String taskId) async {
    try {
      final response = await baseService.put('task/$taskId');
      final success = response.data['success'];
      return success;
    } catch (_) {
      return false;
    }
  }

  Future<String> createTask(Map<String, dynamic> task) async {
    try {
      final response = await baseService.post('tasks', task);
      final taskId = response.data['id'];
      return taskId;
    } catch (_) {
      return '';
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      final response = await baseService.delete('task/$taskId');
      final success = response.data['success'];
      return success;
    } catch (_) {
      return false;
    }
  }
}