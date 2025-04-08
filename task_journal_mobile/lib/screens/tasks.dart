import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Center(
            child: switch (tasks.length) {
              0 => const Text('No tasks.'), 
              _ => ListView(children: [
                      for(var i = 0; i < tasks.length; i++) 
                        TaskRow(task: tasks[i], completeTaskCallback: completeTask,),
                    ],
                  ),
            },
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