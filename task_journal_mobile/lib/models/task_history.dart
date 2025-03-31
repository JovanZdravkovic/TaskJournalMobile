import 'dart:core';

import 'package:uuid/uuid.dart';

class TaskHistory {
  final Uuid id;
  final int? execRating;
  final String? execComment;
  final Uuid taskId;
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
    return switch (json) {
      {
        'id': Uuid id,
        'execRating': int? execRating,
        'execComment': String execComment,
        'taskId': Uuid taskId,
        'taskName': String taskName,
        'taskIcon': String taskIcon,
      } =>
        TaskHistory(
          id: id,
          execRating: execRating,
          execComment: execComment,
          taskId: taskId,
          taskName: taskName,
          taskIcon: taskIcon,
        ),
      _ => throw const FormatException('Failed to parse task history json.'),
    };
  }
}