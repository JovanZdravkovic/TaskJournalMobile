import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({ super.key });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = Provider.of<TasksService>(context, listen: false).getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Center(
        child: FutureBuilder(
          future: tasks, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(children: [
                for(var i = 0; i < snapshot.data!.length; i++) 
                  ListTile(
                    title: Text(snapshot.data![i].taskName),
                  ),
              ],);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}