import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/utils/task_form_validators.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/label_divider.dart';
import 'package:task_journal_mobile/widgets/star_input.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class TaskFormWidget extends StatefulWidget {

  final GlobalKey<FormState> taskFormKey;
  final TextEditingController taskNameController;
  final TextEditingController taskDescController;
  final void Function(bool value) setStarredCallback;
  final void Function(TaskIconEnum? icon) setIconCallback;
  final void Function(DateTime? deadline) setDeadlineCallback;
  final Task? initTask;
  final String? iconFieldError;

  const TaskFormWidget({super.key, required this.taskFormKey, required this.taskNameController, required this.taskDescController, this.iconFieldError, required this.setStarredCallback, required this.setIconCallback, required this.setDeadlineCallback, this.initTask});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {

  DateTime? deadline;

  @override
  void initState() {
    if(widget.initTask != null) {
      widget.taskNameController.text = widget.initTask!.taskName;
      widget.taskDescController.text = widget.initTask!.taskDesc;
      deadline = widget.initTask!.deadline;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Form(
          key: widget.taskFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: kMediumInputWidth,
                    child: TextFormField(
                      controller: widget.taskNameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter task name',
                      ),
                      validator: (value) => TaskFormValidators.taskName(value),
                    ),
                  ),
                  const SizedBox(
                    height: kSmallSpacingBoxSize,
                    width: kSmallSpacingBoxSize,
                  ),
                  StarInput(setCallback: widget.setStarredCallback, initValue: widget.initTask?.starred,),
                ],
              ),
              const SizedBox(
                height: kSmallSpacingBoxSize,
                width: kSmallSpacingBoxSize,
              ),
              IconSelectWidget(setIconCallback: widget.setIconCallback, initSingleIconValue: widget.initTask?.taskIcon,),
              if(widget.iconFieldError != null)
                Text('${widget.iconFieldError}', style: dangerTextStyle,),
              const SizedBox(
                height: kSmallSpacingBoxSize,
                width: kSmallSpacingBoxSize,
              ),
              SizedBox(
                child: TextFormField(
                  maxLines: 5,
                  controller: widget.taskDescController,
                  decoration: const InputDecoration(
                    labelText: 'Enter task description',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) => TaskFormValidators.taskDesc(value),
                ),
              ),
              const SizedBox(
                height: kSmallSpacingBoxSize,
                width: kSmallSpacingBoxSize,
              ),
              labelDivider('Optional'),
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
                        currentTime: deadline,
                        onChanged: (date) {}, 
                        onConfirm: (date) {
                          setState(() {
                            deadline = date;
                            widget.setDeadlineCallback(date);
                          });
                        },
                      );
                    },
                    label: const Text('Deadline'),
                  ),
                  const SizedBox(
                    height: kSmallSpacingBoxSize,
                    width: kSmallSpacingBoxSize,
                  ),
                  if(deadline != null)
                    Text(DateFormat('HH:mm - dd MMM y').format(deadline!)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}