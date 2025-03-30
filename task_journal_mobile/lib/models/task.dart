import 'dart:core';

import 'package:uuid/uuid.dart';

class Task {
  final Uuid id;
  final String taskName;
  final String taskIcon;
  final String taskDesc;
  final DateTime? deadline;
  final bool starred;
  final String execStatus;
  final DateTime createdAt;
  final Uuid createdBy;

  Task({ 
    required this.id ,
    required this.taskName,
    required this.taskIcon,
    required this.taskDesc,
    required this.deadline,
    required this.starred,
    required this.execStatus,
    required this.createdAt,
    required this.createdBy
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': Uuid id,
        'taskName': String taskName,
        'taskIcon': String taskIcon,
        'taskDesc': String taskDesc,
        'deadline': DateTime? deadline,
        'starred': bool starred,
        'execStatus': String execStatus,
        'createdAt': DateTime createdAt,
        'createdBy': Uuid createdBy
      } =>
        Task(
          id: id,
          taskName: taskName,
          taskIcon: taskIcon,
          taskDesc: taskDesc,
          deadline: deadline,
          starred: starred,
          execStatus: execStatus,
          createdAt: createdAt,
          createdBy: createdBy
        ),
      _ => throw const FormatException('Failed to parse task json.'),
    };
  }
}