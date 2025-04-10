import 'package:flutter/material.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({ super.key });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  String? iconField;

  void setIcon(TaskIconEnum? icon) {
    setState(() {
      iconField = icon?.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New task'),
      ),
      body: Center(
        child: IconSelectWidget(setIconCallback: setIcon),
      ),
    );
  }
}