import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';
import 'package:task_journal_mobile/widgets/label_divider.dart';
import 'package:task_journal_mobile/widgets/search_bar.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';
import 'package:task_journal_mobile/widgets/task_row.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({ super.key });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await Provider.of<TasksService>(context, listen: false).getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  void completeTask(String taskId) {
    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
    });
  }

  void setIcon(TaskIconEnum? icon) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: kMediumInputWidth,
              child: SearchBarWidget(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      FaIcon(FontAwesomeIcons.calendarDays, color: white, size: kSmallIconSize,),
                      Text(' Deadline '),
                      FaIcon(FontAwesomeIcons.arrowUp, color: white, size: kSmallIconSize,),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kSmallSpacingBoxSize,
                  width: kSmallSpacingBoxSize,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      FaIcon(FontAwesomeIcons.solidStar, color: white, size: kSmallIconSize,),
                      Text(' Starred '),
                      FaIcon(FontAwesomeIcons.arrowUp, color: white, size: kSmallIconSize,),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kSmallSpacingBoxSize,
                  width: kSmallSpacingBoxSize,
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: FaIcon(FontAwesomeIcons.arrowsRotate, color: Colors.grey.shade400,),
                ),
              ],
            ),
            labelDivider('Tasks'),
            Expanded(
              child: switch (tasks.length) {
                0 => const Text('No tasks.'), 
                _ => ListView(children: [
                        for(var i = 0; i < tasks.length; i++) 
                          TaskRow(task: tasks[i], completeTaskCallback: completeTask,),
                      ],
                    ),
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: kFloatingActionButtonSize,
        width: kFloatingActionButtonSize,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/new_task');
            },
            shape: const CircleBorder(),
            backgroundColor: secondary,
            child: const FaIcon(FontAwesomeIcons.plus, color: white, size: kLargeIconSize,),
          ),
        ),
      ),
    );
  }
}