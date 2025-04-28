
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

}