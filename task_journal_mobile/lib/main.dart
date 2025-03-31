import 'package:flutter/material.dart';
import 'package:task_journal_mobile/screens/login.dart';
import 'package:task_journal_mobile/screens/profile.dart';
import 'package:task_journal_mobile/screens/tasks.dart';
import 'package:task_journal_mobile/screens/tasks_history.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const TasksPage(),
        '/tasks': (context) => const TasksPage(),
        '/tasks_history': (context) => const TasksHistoryPage(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
      },
      theme: appTheme,
    );
  }
}
