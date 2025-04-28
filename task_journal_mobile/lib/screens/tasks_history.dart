import 'package:flutter/material.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';
import 'package:task_journal_mobile/widgets/rating_input.dart';

class TasksHistoryPage extends StatefulWidget {
  const TasksHistoryPage({ super.key });

  @override
  State<TasksHistoryPage> createState() => _TasksHistoryPageState();
}

class _TasksHistoryPageState extends State<TasksHistoryPage> {

  int? starRating;

  void setStarRating(int rating){
    setState(() {
      starRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks history'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: const Center(
        child: Text('Tasks history page'),
      ),
    );
  }
}