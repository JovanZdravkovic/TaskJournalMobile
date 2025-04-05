import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskRow extends StatelessWidget {
  
  final Task task;

  const TaskRow({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Row(
          children: [
            TaskIcon(
              taskIcon: task.taskIcon,
            ),
            const SizedBox(
              width: kSmallSpacingBoxSize,
            ),
            Text(
              task.taskName, 
              style: cardTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}