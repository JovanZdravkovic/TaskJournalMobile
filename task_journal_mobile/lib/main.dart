import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/screens/login.dart';
import 'package:task_journal_mobile/screens/profile.dart';
import 'package:task_journal_mobile/screens/tasks.dart';
import 'package:task_journal_mobile/screens/tasks_history.dart';
import 'package:task_journal_mobile/services/auth_service.dart';
import 'package:task_journal_mobile/services/base_service.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/auth_guard.dart';
import 'package:task_journal_mobile/utils/theme.dart';

void main() {
  
  final dio = Dio();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => BaseService(dio: dio)),
        ProxyProvider<BaseService, AuthService>(
          update: (context, baseService, previous) => AuthService(baseService: baseService),
        ),
        ProxyProvider<BaseService, TasksService>(
          update: (context, baseService, previous) => TasksService(baseService: baseService),
        ),
      ],
      child: const TaskJournalApp(),
    )
  );
}

class TaskJournalApp extends StatelessWidget {
  const TaskJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Journal',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGuard(child: TasksPage()),
        '/tasks': (context) => const AuthGuard(child: TasksPage()),
        '/tasks_history': (context) => const AuthGuard(child: TasksHistoryPage()),
        '/profile': (context) => const AuthGuard(child: ProfilePage()),
        '/login': (context) => const LoginPage(),
      },
      theme: appTheme,
    );
  }
}
