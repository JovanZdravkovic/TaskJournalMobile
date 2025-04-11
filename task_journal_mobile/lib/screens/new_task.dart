import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/star_input.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({ super.key });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _taskNameController = TextEditingController();
  final _taskDescController = TextEditingController();
  final _newTaskFormKey = GlobalKey<FormState>();
  String? iconField;
  bool? starred;

  void setStarred(bool? starredValue) {
    starred = starredValue;
  }

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
      body: Padding(
        padding: const EdgeInsets.all(kLargePadding),
        child: Form(
          key: _newTaskFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: kMediumInputWidth,
                    child: TextFormField(
                      controller: _taskNameController,
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
                height: kSpacingBoxSize,
                width: kSpacingBoxSize,
              ),
              IconSelectWidget(setIconCallback: setIcon),
              const SizedBox(
                height: kSpacingBoxSize,
                width: kSpacingBoxSize,
              ),
              SizedBox(
                width: kMediumInputWidth,
                child: TextFormField(
                  maxLines: 6,
                  controller: _taskDescController,
                  decoration: const InputDecoration(
                    labelText: 'Enter task description',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ],
          ),
        ), 
      ),
      floatingActionButton: SizedBox(
        height: kFloatingActionButtonSize,
        width: kFloatingActionButtonSize,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: secondary,
            child: const FaIcon(FontAwesomeIcons.solidFloppyDisk, color: white, size: kLargeIconSize,),
          ),
        ),
      ),
    );
  }
}