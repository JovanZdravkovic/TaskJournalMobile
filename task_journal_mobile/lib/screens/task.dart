import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';
import 'package:task_journal_mobile/widgets/star_input.dart';
import 'package:task_journal_mobile/widgets/task_form.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class TaskPage extends StatefulWidget {

  final String taskId;

  const TaskPage({ super.key, required this.taskId });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final editTaskFormKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final taskDescController = TextEditingController();
  String? taskIcon;
  bool starred = false;
  DateTime? deadline;

  Task? task;
  bool editMode = false;

  Future<void> loadTask() async {
    final loadedTask = await Provider.of<TasksService>(context, listen: false).getTask(widget.taskId);
    setState(() {
      task = loadedTask;
    });
  }

  void setStarred(bool? starredValue) {
    setState(() {
      if(starredValue != null) {
        starred = starredValue;
      }
    });
  }

  void setIconValue(String? iconValue) {
    setState(() {
      if(iconValue != null) {
        taskIcon = iconValue;
      }
    });
  }

  void setIconEnum(TaskIconEnum? iconEnum) {
    setState(() {
      if(iconEnum != null) {
        taskIcon = iconEnum.value;
      }
    });
  }

  void setDeadline(DateTime? deadlineValue) {
    setState(() {
      deadline = deadlineValue;
    });
  }

  void resetFormValues() {
    taskNameController.text = task!.taskName;
    taskDescController.text = task!.taskDesc;
    setIconValue(task!.taskIcon);
    setStarred(task!.starred);
    setDeadline(task!.deadline);
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
      resetFormValues();
    });
  }

  void updateTask() async {
    final result = await Provider.of<TasksService>(context, listen: false).updateTask(
      { 
        'taskName': taskNameController.text,
        'taskIcon': taskIcon,
        'taskDesc': taskDescController.text,
        'deadline': deadline?.toUtc().toIso8601String(),
        'starred': starred,
      },
      widget.taskId
    );

    if (!context.mounted) return;

    if(result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully updated task'));
      loadTask();
      toggleEditMode();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while updating task'));
    }
  }

  void deleteTask() async {
    var result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this task?'),
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

      final successResult = await Provider.of<TasksService>(context, listen: false).deleteTask(widget.taskId);

      if (!context.mounted) return;

      if(successResult) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully deleted task'));
        Navigator.pushNamed(context, '/tasks');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while deleting task'));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(task != null) {
      if(editMode) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('Edit task'),
        ),
        body: Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(kLargePadding),
              child: TaskFormWidget(
                taskFormKey: editTaskFormKey, 
                taskNameController: taskNameController, 
                taskDescController: taskDescController, 
                setStarredCallback: setStarred, 
                setIconCallback: setIconEnum, 
                setDeadlineCallback: setDeadline,
                initTask: task,
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
            width: kMediumInputWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: kFloatingActionButtonSize,
                  width: kFloatingActionButtonSize,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: updateTask,
                      heroTag: null,
                      shape: const CircleBorder(),
                      backgroundColor: dark,
                      child: const FaIcon(FontAwesomeIcons.check, color: white, size: kLargeIconSize,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpacingBoxSize,
                  width: kSpacingBoxSize,
                ),
                SizedBox(
                  height: kFloatingActionButtonSize,
                  width: kFloatingActionButtonSize,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: toggleEditMode,
                      heroTag: null,
                      shape: const CircleBorder(),
                      backgroundColor: dark,
                      child: const FaIcon(FontAwesomeIcons.xmark, color: white, size: kLargeIconSize,),
                    ),
                  ),
                ),
              ],
            ),
          ),
      );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(kLargePadding),
              child: Container(
                decoration: containerDecoration,
                height: kTaskCardHeight,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kStandardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TaskIcon(taskIcon: task!.taskIcon),
                          const SizedBox(
                            height: kSmallSpacingBoxSize,
                            width: kSmallSpacingBoxSize,
                          ),
                          Expanded(
                            child: Text(
                              task!.taskName,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: cardTextStyle,
                            ), 
                          ),
                          switch (task!.starred) {
                            true => const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kLargeIconSize),
                            false => const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kLargeIconSize),
                          }
                        ],
                      ),
                      const SizedBox(
                        height: kExtraSmallSpacingBoxSize,
                        width: kExtraSmallSpacingBoxSize,
                      ),
                      const Divider(color: grayDark, thickness: 2.0,),
                      const SizedBox(
                        height: kExtraSmallSpacingBoxSize,
                        width: kExtraSmallSpacingBoxSize,
                      ),
                      Expanded(
                        child: Text(task!.taskDesc, style: cardTextStyle,),
                      ),
                      const SizedBox(
                        height: kSmallSpacingBoxSize,
                        width: kSmallSpacingBoxSize,
                      ),
                      if(task!.deadline != null)
                        Text('Deadline: ${DateFormat('HH:mm - dd. MMM yyyy').format(task!.deadline!)}', style: cardTextStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: kMediumInputWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: kFloatingActionButtonSize,
                  width: kFloatingActionButtonSize,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: toggleEditMode,
                      heroTag: null,
                      shape: const CircleBorder(),
                      backgroundColor: dark,
                      child: const FaIcon(FontAwesomeIcons.pencil, color: white, size: kLargeIconSize,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpacingBoxSize,
                  width: kSpacingBoxSize,
                ),
                SizedBox(
                  height: kFloatingActionButtonSize,
                  width: kFloatingActionButtonSize,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: deleteTask,
                      heroTag: null,
                      shape: const CircleBorder(),
                      backgroundColor: dark,
                      child: const FaIcon(FontAwesomeIcons.trashCan, color: white, size: kLargeIconSize,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}