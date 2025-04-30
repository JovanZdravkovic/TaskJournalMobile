import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/rating_input.dart';
import 'package:task_journal_mobile/widgets/task_icon.dart';

class TaskHistoryFormWidget extends StatelessWidget {
  
  final GlobalKey<FormState> taskHistoryFormKey;
  final TaskHistory taskHistory;
  final void Function(int rating) setRatingCallback;
  final TextEditingController execCommentController;
  final int? rating;

  const TaskHistoryFormWidget({
    super.key, 
    required this.taskHistoryFormKey, 
    required this.taskHistory, 
    required this.setRatingCallback, 
    required this.execCommentController, 
    this.rating
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration,
      height: kTaskCardHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Form(
          key: taskHistoryFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(
                    height: kSmallSpacingBoxSize,
                    width: kSmallSpacingBoxSize,
                  ),
                  RatingInputWidget(setRatingCallback: setRatingCallback, rating: rating, showPlaceholder: false, showBorder: false,),
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
              SizedBox(
                child: TextFormField(
                  maxLines: 10,
                  controller: execCommentController,
                  decoration: const InputDecoration(
                    labelText: 'Enter execution comment',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}