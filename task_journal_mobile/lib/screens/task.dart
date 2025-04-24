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
import 'package:task_journal_mobile/widgets/task_icon.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class TaskPage extends StatefulWidget {

  final String taskId;

  const TaskPage({ super.key, required this.taskId });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Task? task;
  bool editMode = false;

  Future<void> loadTask() async {
    final loadedTask = await Provider.of<TasksService>(context, listen: false).getTask(widget.taskId);
    setState(() {
      task = loadedTask;
    });
  }

  void setStarred(bool? starredValue) {}

  void setIcon(TaskIconEnum? icon) {}

  @override
  void initState() {
    super.initState();
    loadTask();
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
                          SizedBox(
                            width: kMediumInputWidth,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Enter task name',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: kSmallSpacingBoxSize,
                            width: kSmallSpacingBoxSize,
                          ),
                          StarInput(setCallback: setStarred),
                        ],
                      ),
                      const SizedBox(
                        height: kSmallSpacingBoxSize,
                        width: kSmallSpacingBoxSize,
                      ),
                      IconSelectWidget(setIconCallback: setIcon),
                      const SizedBox(
                        height: kSmallSpacingBoxSize,
                        width: kSmallSpacingBoxSize,
                      ),
                      SizedBox(
                        child: TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Enter task description',
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kSmallSpacingBoxSize,
                        width: kSmallSpacingBoxSize,
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.calendar_month, color: white,),
                            onPressed: () {
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(2025, 1, 1),
                                maxTime: DateTime(2050, 1, 1), 
                                onChanged: (date) {}, 
                                onConfirm: (date) {},
                              );
                            },
                            label: const Text('Deadline'),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      onPressed: () {},
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
                      onPressed: () {
                        setState(() {
                          editMode = false;
                        });
                      },
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
                      Divider(color: grayDark, thickness: 2.0,),
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
                      onPressed: () {
                        setState(() {
                          editMode = true;
                        });
                      },
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
                      onPressed: () async {
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

                        if (!context.mounted) return;

                        if(result != null && result) {
                          final successResult = await Provider.of<TasksService>(context, listen: false).deleteTask(widget.taskId);

                          if (!context.mounted) return;

                          if(successResult) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully deleted task'));
                            Navigator.pushNamed(context, '/tasks');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while deleting task'));
                          }
                        }
                      },
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