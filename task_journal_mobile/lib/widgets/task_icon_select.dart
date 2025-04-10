
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

enum TaskIconEnum {

  job('job', 'Job'),
  doctorAppointment('doctor_appointment', 'Doctor appointment'),
  mechanic('mechanic', 'Mechanic'),
  cleaning('cleaning', 'Cleaning'),
  gym('gym', 'Gym'),
  swimming('swimming', 'Swimming'),
  running('running', 'Running'),
  basketball('basketball', 'Basketball'),
  football('football', 'Football'),
  americanFootball('american_football', 'American football'),
  volleyball('volleyball', 'Volleyball'),
  concert('concert', 'Concert'),
  movie('movie', 'Movie'),
  meeting('meeting', 'Meeting'),
  transport('transport', 'Transport'),
  reading('reading', 'Reading'),
  writing('writing', 'Writing'),
  payment('payment', 'Payment'),
  message('message', 'Message'),
  photography('photography', 'Photography'),
  drive('drive', 'Drive'),
  shopping('shopping', 'Shopping'),
  coffe('coffee', 'Coffee'),
  sailing('sailing', 'Sailing'),
  church('church', 'Church'),
  pets('pets', 'Pets'),
  plants('plants', 'Plants'),
  lunch('lunch', 'Lunch'),
  phoneCall('phone_call', 'Phone call'),
  computer('computer', 'Computer'),
  moving('moving', 'Moving'),
  electrician('electrician', 'Electrician'),
  party('party', 'Party');

  const TaskIconEnum(this.value, this.label);

  final String value;
  final String label;

  static final List<DropdownMenuEntry<TaskIconEnum>> entries = UnmodifiableListView<DropdownMenuEntry<TaskIconEnum>>(
    values.map<DropdownMenuEntry<TaskIconEnum>>(
      (TaskIconEnum taskIcon) => DropdownMenuEntry<TaskIconEnum>(
        value: taskIcon,
        label: taskIcon.label,
        leadingIcon: TaskIcon(taskIcon: taskIcon.value),
      ),
    ),
  );
}

class IconSelectWidget extends StatefulWidget {

  final void Function(TaskIconEnum? icon) setIconCallback;

  const IconSelectWidget({super.key, required this.setIconCallback});

  @override
  State<IconSelectWidget> createState() => _IconSelectWidgetState();
}

class _IconSelectWidgetState extends State<IconSelectWidget> {

  String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: value != null ? TaskIcon(taskIcon: value!) : const Text('Task icon'),
      dropdownMenuEntries: TaskIconEnum.entries,
      onSelected: (TaskIconEnum? icon) {
        setState(() {
          value = icon?.value;
        });
        widget.setIconCallback(icon);
      },
      menuHeight: kTaskIconSelectHeight,
      enabled: true,
    );
  }
}