
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/services/base_service.dart';

class TasksHistoryService {
  final BaseService baseService;

  TasksHistoryService({ required this.baseService });

  List<TaskHistory> parseTasksHistoryJson(List<dynamic> jsonResponse) {
    final parsedList = jsonResponse.cast<Map<String, dynamic>>();
    return parsedList.map<TaskHistory>((json) => TaskHistory.fromJson(json)).toList();
  }


  Future<List<TaskHistory>> getTasksHistory([Map<String, dynamic>? queryParams]) async {
    try {
      final response = await baseService.get('tasks_history', queryParams);
      final tasks = parseTasksHistoryJson(response.data);
      return tasks;
    } catch (_) {
      return [];
    }
  }

  Future<TaskHistory?> getTaskHistory(String taskHistoryId) async {
    try {
      final response = await baseService.get('task_history/$taskHistoryId');
      final taskHistory = TaskHistory.fromJson(response.data);
      return taskHistory;
    } catch (_) {
      return null;
    }
  }

  Future<bool> deleteTaskHistory(String taskHistoryId) async {
    try {
      final response = await baseService.delete('task_history/$taskHistoryId');
      final success = response.data['success'];
      return success;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateTaskHistory(Map<String, dynamic> taskHistory, String taskHistoryId) async {
    try {
      final response = await baseService.put('task_history/$taskHistoryId', taskHistory);
      final success = response.data['success'];
      return success;
    } catch (_) {
      return false;
    }
  }
}