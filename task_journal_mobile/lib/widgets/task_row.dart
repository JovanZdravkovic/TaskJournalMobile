import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task.dart';
import 'package:task_journal_mobile/services/tasks_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskRow extends StatelessWidget {
  
  final Task task;
  final void Function(String taskId) completeTaskCallback;

  const TaskRow({super.key, required this.task, required this.completeTaskCallback});

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
            Expanded(
              child: Text(
                task.taskName,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: cardTextStyle,
              ), 
            ),
            if (task.starred)
              const FaIcon(FontAwesomeIcons.solidStar, color: starYellow),
            const SizedBox(
              width: kSmallSpacingBoxSize,
            ),
            Ink(
              height: kSmallIconButtonSize,
              width: kSmallIconButtonSize,
              decoration: const ShapeDecoration(color: primaryLight, shape: CircleBorder()),
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.check),
                color: white,
                onPressed: () async {
                  final result = await Provider.of<TasksService>(context, listen: false).completeTask(task.id);
                  if(!context.mounted) {
                    return ;
                  }
                  if(result) {
                    completeTaskCallback(task.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.success('Successfully completed task'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error while completing task'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}