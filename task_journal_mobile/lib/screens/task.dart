import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({ super.key });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kStandardPadding),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(kInputBorderRadius)),
              color: grayDark,
            ),
            height: kTaskCardHeight,
            width: double.infinity,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: kMediumInputWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: kFloatingActionButtonSize,
              width: kFloatingActionButtonSize,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {},
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: dark,
                  child: const FaIcon(FontAwesomeIcons.pencil, color: white, size: kLargeIconSize,),
                ),
              ),
            ),
            const SizedBox(
              height: kSpacingBoxSize,
              width: kSpacingBoxSize,
            ),
            SizedBox(
              height: kFloatingActionButtonSize,
              width: kFloatingActionButtonSize,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {},
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: danger,
                  child: const FaIcon(FontAwesomeIcons.trashCan, color: white, size: kLargeIconSize,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}