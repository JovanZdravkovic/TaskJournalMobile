import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/screens/task_history.dart';
import 'package:task_journal_mobile/utils/auth_guard.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/rating.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskHistoryRow extends StatelessWidget {
  final TaskHistory taskHistory;
  final void Function() loadTasksHistoryCallback;

  const TaskHistoryRow({super.key, required this.taskHistory, required this.loadTasksHistoryCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthGuard(child: TaskHistoryPage(taskHistoryId: taskHistory.id)),
            ),
          ).then((value) => loadTasksHistoryCallback());
        },
        borderRadius: const BorderRadius.all(Radius.circular(kCardBorderRadius)),
        child: Padding(
          padding: const EdgeInsets.all(kStandardPadding),
          child: Row(
            children: [
              TaskIcon(
                taskIcon: taskHistory.taskIcon,
              ),
              const SizedBox(
                width: kExtraSmallSpacingBoxSize,
              ),
              Expanded(
                child: Text(
                  taskHistory.taskName,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: cardTextStyle,
                ), 
              ),
              const SizedBox(
                width: kExtraSmallSpacingBoxSize,
              ),
              if(taskHistory.execRating != null)
                RatingWidget(rating: taskHistory.execRating!),
            ],
          ),
        ),
      ),
    );
  }
  
}