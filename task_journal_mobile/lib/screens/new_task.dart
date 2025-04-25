import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/task_form_validators.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/label_divider.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';
import 'package:task_journal_mobile/widgets/star_input.dart';
import 'package:task_journal_mobile/widgets/task_form.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({ super.key });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _newTaskFormKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescController = TextEditingController();
  DateTime? deadline;
  String? iconField;
  String? iconFieldError;
  bool? starred = false;

  void setStarred(bool? starredValue) {
    starred = starredValue;
  }

  void setIconEnum(TaskIconEnum? icon) {
    setState(() {
      iconField = icon?.value;
    });
  }

  void setDeadline(DateTime? deadlineValue) {
    setState(() {
      deadline = deadlineValue;
    });
  }

  void createTask() async {
    if(_newTaskFormKey.currentState!.validate() && iconField != null && starred != null) {
      final result = await Provider.of<TasksService>(context, listen: false).createTask(
        { 
          'taskName': _taskNameController.text,
          'taskIcon': iconField,
          'taskDesc': _taskDescController.text,
          'deadline': deadline?.toUtc().toIso8601String(),
          'starred': starred,
        }
      );

      if (!context.mounted) return;

      if(result != '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully created task'));
        Navigator.pushNamed(context, '/tasks');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while creating task'));
      }
    } else {
      if(iconField == null) {
        setState(() {
          iconFieldError = 'Task icon cannot be empty';
        });
      } else {
        setState(() {
          iconFieldError = null;
        });
      }
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kLargePadding),
          child: TaskFormWidget(
            taskFormKey: _newTaskFormKey, 
            taskNameController: _taskNameController, 
            taskDescController: _taskDescController, 
            setStarredCallback: setStarred, 
            setIconCallback: setIconEnum, 
            setDeadlineCallback: setDeadline,
            iconFieldError: iconFieldError,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: kFloatingActionButtonSize,
        width: kFloatingActionButtonSize,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: createTask,
            shape: const CircleBorder(),
            backgroundColor: secondary,
            child: const FaIcon(FontAwesomeIcons.solidFloppyDisk, color: white, size: kLargeIconSize,),
          ),
        ),
      ),
    );
  }
}