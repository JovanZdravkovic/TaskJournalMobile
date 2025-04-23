import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskPage extends StatefulWidget {

  final String taskId;

  const TaskPage({ super.key, required this.taskId });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Task? task;

  Future<void> loadTask() async {
    final loadedTask = await Provider.of<TasksService>(context, listen: false).getTask(widget.taskId);
    setState(() {
      task = loadedTask;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    if(task != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(kLargePadding),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kInputBorderRadius)),
                color: grayDark,
              ),
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
                      height: kSmallSpacingBoxSize,
                      width: kSmallSpacingBoxSize,
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
                    onPressed: () {},
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
                    onPressed: () {},
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