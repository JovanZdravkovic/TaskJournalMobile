import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/rating.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskHistoryCardWidget extends StatelessWidget {

  final TaskHistory taskHistory;
  
  const TaskHistoryCardWidget({super.key, required this.taskHistory});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration,
      height: kTaskCardHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TaskIcon(taskIcon: taskHistory.taskIcon),
                const SizedBox(
                  height: kSmallSpacingBoxSize,
                  width: kSmallSpacingBoxSize,
                ),
                Expanded(
                  child: Text(
                    taskHistory.taskName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: cardTextStyle,
                  ), 
                ),
                if(taskHistory.execRating != null)
                  RatingWidget(rating: taskHistory.execRating!),
              ],
            ),
            const SizedBox(
              height: kExtraSmallSpacingBoxSize,
              width: kExtraSmallSpacingBoxSize,
            ),
            const Divider(color: grayDark, thickness: 2.0,),
            const SizedBox(
              height: kExtraSmallSpacingBoxSize,
              width: kExtraSmallSpacingBoxSize,
            ),
            Expanded(
              child: Text(taskHistory.execComment != null ? taskHistory.execComment! : 'No execution comment', style: cardTextStyle,),
            ),
            const SizedBox(
              height: kSmallSpacingBoxSize,
              width: kSmallSpacingBoxSize,
            ),
          ],
        ),
      ),
    );
  }
}