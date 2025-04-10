import 'dart:core';

class TaskHistory {
  final String id;
  final int? execRating;
  final String? execComment;
  final String taskId;
  final String taskName;
  final String taskIcon;

  TaskHistory({ 
    required this.id ,
    required this.execRating,
    required this.execComment,
    required this.taskId,
    required this.taskName,
    required this.taskIcon,
  });

  factory TaskHistory.fromJson(Map<String, dynamic> json) {
    try {
      return TaskHistory(
        id: json['id'],
        execRating: json['execRating'],
        execComment: json['execComment'],
        taskId: json['taskId'],
        taskName: json['taskName'],
        taskIcon: json['taskIcon'],
      );
    } catch (e) {
      throw FormatException('Failed to parse task history json: $e');
    }
  }
}