import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/services/tasks_history_service.dart';
import 'package:task_journal_mobile/widgets/edit_tools.dart';
import 'package:task_journal_mobile/widgets/form_submit_tools.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';
import 'package:task_journal_mobile/widgets/task_history_card.dart';
import 'package:task_journal_mobile/widgets/task_history_form.dart';

class TaskHistoryPage extends StatefulWidget {

  final String taskHistoryId;

  const TaskHistoryPage({ super.key, required this.taskHistoryId });

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {

  TaskHistory? taskHistory;
  int? rating;
  bool editMode = false;
  final TextEditingController execCommentController = TextEditingController();
  final editTaskHistoryFormKey = GlobalKey<FormState>();

  Future<void> loadTaskHistory() async {
    final loadedTaskHistory = await Provider.of<TasksHistoryService>(context, listen: false).getTaskHistory(widget.taskHistoryId);
    setState(() {
      taskHistory = loadedTaskHistory;
    });
  }

  void resetFormValues() {
    if(taskHistory!.execComment != null) {
      execCommentController.text = taskHistory!.execComment!;
    }
    setRating(taskHistory!.execRating);
  }

  void updateTaskHistory() async {
    if(editTaskHistoryFormKey.currentState!.validate()) {
      final result = await Provider.of<TasksHistoryService>(context, listen: false).updateTaskHistory(
        { 
          'execComment': execCommentController.text,
          'execRating': rating,
        },
        widget.taskHistoryId
      );

      if (!context.mounted) return;

      if(result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully updated task history'));
        loadTaskHistory();
        toggleEditMode();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while updating task history'));
      }
    }
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
      resetFormValues();
    });
  }

  void setRating(int? ratingValue) {
    setState(() {
      rating = ratingValue;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTaskHistory();
  }

  @override
  void dispose() {
    execCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(taskHistory != null) {
      if(editMode) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit task history'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(kLargePadding),
              child: TaskHistoryFormWidget(
                taskHistoryFormKey: editTaskHistoryFormKey, 
                taskHistory: taskHistory!, 
                setRatingCallback: setRating, 
                execCommentController: execCommentController,
                rating: rating,
              ),
            ),
          ),
          floatingActionButton: FormSubmitToolsWidget(firstCallback: updateTaskHistory, secondCallback: toggleEditMode),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task history'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(kLargePadding),
              child: TaskHistoryCardWidget(taskHistory: taskHistory!),
            ),
          ),
          floatingActionButton: EditToolsWidget(firstCallback: toggleEditMode, secondCallback: deleteTaskHistory),
        );
      }
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