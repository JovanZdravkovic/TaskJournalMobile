import 'package:flutter/material.dart';
import 'package:task_journal_mobile/screens/tasks.dart';
import 'package:task_journal_mobile/utils/theme.dart';

void main() {
  runApp(const TaskJournalApp());
}

class TaskJournalApp extends StatelessWidget {
  const TaskJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Journal',
      theme: appTheme,
      home: const TasksPage(),
    );
  }
}
