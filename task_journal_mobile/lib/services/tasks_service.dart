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
      final success = parseTasksJson(response.data);
      return success;
    } catch (_) {
      return [];
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
}