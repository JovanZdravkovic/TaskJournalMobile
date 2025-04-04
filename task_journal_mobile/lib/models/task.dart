import 'dart:core';

import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String taskName;
  final String taskIcon;
  final String taskDesc;
  final DateTime? deadline;
  final bool starred;
  final String execStatus;
  final DateTime createdAt;
  final String createdBy;

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
    try {
      return Task(
        id: json['id'],
        taskName: json['taskName'],
        taskIcon: json['taskIcon'],
        taskDesc: json['taskDesc'],
        deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
        starred: json['starred'],
        execStatus: json['execStatus'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
      );
    } catch (e) {
      throw FormatException('Failed to parse task json: $e');
    }
  }
}