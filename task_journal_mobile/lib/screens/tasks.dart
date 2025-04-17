import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
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
  String? searchOrderBy;
  final _searchNameController = TextEditingController();
  MultiSelectController<TaskIconEnum> iconSelectController = MultiSelectController<TaskIconEnum>();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Map<String, dynamic> createPayload() {
    return {
      'searchName': _searchNameController.text,
      'searchOrderBy': searchOrderBy,
    };
  }

  Future<void> loadTasks() async {
    final loadedTasks = await Provider.of<TasksService>(context, listen: false).getTasks(createPayload());
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
            SizedBox(
              width: kMediumInputWidth,
              child: SearchBarWidget(controller: _searchNameController,),
            ),
            const SizedBox(
              height: kSmallSpacingBoxSize,
              width: kSmallSpacingBoxSize,
            ),
            IconSelectWidget(setIconCallback: setIcon, initMultipleValue: true, initMultipleController: iconSelectController,),
            const SizedBox(
              height: kSmallSpacingBoxSize,
              width: kSmallSpacingBoxSize,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchOrderBy = 'deadline';
                      loadTasks();
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      searchOrderBy = 'starred';
                      loadTasks();
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      _searchNameController.text = '';
                      searchOrderBy = null;
                      iconSelectController.clearAll();
                      loadTasks();
                    });
                  }, 
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