import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/services/tasks_history_service.dart';
import 'package:task_journal_mobile/widgets/edit_tools.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';

class TaskHistoryPage extends StatefulWidget {

  final String taskHistoryId;

  const TaskHistoryPage({ super.key, required this.taskHistoryId });

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {

  TaskHistory? taskHistory;
  bool editMode = false;

  Future<void> loadTaskHistory() async {
    final loadedTaskHistory = await Provider.of<TasksHistoryService>(context, listen: false).getTaskHistory(widget.taskHistoryId);
    setState(() {
      taskHistory = loadedTaskHistory;
    });
  }

  void deleteTaskHistory() async {
    var result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this task history?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if(result != null && result) {
      if (!context.mounted) return;

      final successResult = await Provider.of<TasksHistoryService>(context, listen: false).deleteTaskHistory(widget.taskHistoryId);

      if (!context.mounted) return;

      if(successResult) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully deleted task history'));
        Navigator.pushNamed(context, '/tasks_history');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while deleting task history'));
      }
    }
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTaskHistory();
  }

  @override
  Widget build(BuildContext context) {
    if(taskHistory != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task history'),
        ),
        body: Center(
          child: Text(taskHistory!.taskName),
        ),
        floatingActionButton: EditToolsWidget(firstCallback: toggleEditMode, secondCallback: deleteTaskHistory),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task history'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}