
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
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

  static final List<DropdownMenuEntry<TaskIconEnum>> singleSelectEntries = UnmodifiableListView<DropdownMenuEntry<TaskIconEnum>>(
    values.map<DropdownMenuEntry<TaskIconEnum>>(
      (TaskIconEnum taskIcon) => DropdownMenuEntry<TaskIconEnum>(
        value: taskIcon,
        label: taskIcon.label,
        leadingIcon: TaskIcon(taskIcon: taskIcon.value),
      ),
    ),
  );

  static final List<DropdownItem<String>> multiSelectEntries = UnmodifiableListView<DropdownItem<String>>(
    values.map<DropdownItem<String>>(
      (TaskIconEnum taskIcon) => DropdownItem(
        value: taskIcon.value,
        label: taskIcon.label,
      ),
    ),
  );
}

class IconSelectWidget extends StatefulWidget {

  final void Function(TaskIconEnum? icon)? setIconCallback;
  final Future<void> Function()? multipleIconsChangeCallback;
  final bool? initMultipleValue;
  final MultiSelectController<String>? initMultipleController;

  const IconSelectWidget({super.key, this.setIconCallback, this.initMultipleValue, this.initMultipleController, this.multipleIconsChangeCallback});

  @override
  State<IconSelectWidget> createState() => _IconSelectWidgetState();
}

class _IconSelectWidgetState extends State<IconSelectWidget> {

  bool multiple = false;
  List<String>? multiSelectValue;
  String? singleSelectValue;
  MultiSelectController<String>? controller;

  @override
  void initState() {
    super.initState();
    if(widget.initMultipleValue != null) {
      multiple = widget.initMultipleValue!;
    }
    controller = widget.initMultipleController ?? MultiSelectController<String>();
  }

  @override
  Widget build(BuildContext context) {
    if(multiple) {
      return MultiDropdown<String>(
        controller: controller!,
        onSelectionChange: (selected) {
          if(widget.multipleIconsChangeCallback != null) {
            widget.multipleIconsChangeCallback!();
          }
        },
        items: TaskIconEnum.multiSelectEntries,
        enabled: true,
        selectedItemBuilder:(item) {
          return Chip(
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(kChipBorderRadius),
              side: const BorderSide(color: Colors.transparent),
            ),
            padding: const EdgeInsets.all(kExtraSmallPadding),
            label: TaskIcon(taskIcon: item.value),
            deleteIcon: const Icon(Icons.close, size: kSmallIconSize),
            onDeleted: () {
              controller!.unselectWhere((itemIterator) => itemIterator.value == item.value);
            },
          );
        },
        itemBuilder:(item, index, onTap) {
          return Material(
            color: white,
            child: InkWell(
              onTap: onTap,
              child: ListTile(
                leading: TaskIcon(taskIcon: item.value),
                title: Text(item.label),
              ),
            ),
          );
        },
        fieldDecoration: const FieldDecoration(
          labelText: 'Select icons',
        ),
      );
    } else {
      return DropdownMenu(
        label: singleSelectValue != null ? TaskIcon(taskIcon: singleSelectValue!) : const Text('Task icon'),
        dropdownMenuEntries: TaskIconEnum.singleSelectEntries,
        onSelected: (TaskIconEnum? icon) {
          setState(() {
            singleSelectValue = icon?.value;
          });
          if(widget.setIconCallback != null) {
            widget.setIconCallback!(icon);
          }
        },
        menuHeight: kTaskIconSelectHeight,
        enabled: true,
      ); 
    }
  }
}