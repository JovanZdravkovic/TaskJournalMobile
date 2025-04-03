import 'package:flutter/material.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({ super.key });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: const Center(
        child: Text('Tasks page'),
      ),
    );
  }
}