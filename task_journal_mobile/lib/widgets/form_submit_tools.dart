
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class FormSubmitToolsWidget extends StatelessWidget {

  final void Function() firstCallback;
  final void Function() secondCallback;

  const FormSubmitToolsWidget({super.key, required this.firstCallback, required this.secondCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kMediumInputWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: kFloatingActionButtonSize,
            width: kFloatingActionButtonSize,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: firstCallback,
                heroTag: null,
                shape: const CircleBorder(),
                backgroundColor: dark,
                child: const FaIcon(FontAwesomeIcons.check, color: white, size: kLargeIconSize,),
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
                onPressed: secondCallback,
                heroTag: null,
                shape: const CircleBorder(),
                backgroundColor: dark,
                child: const FaIcon(FontAwesomeIcons.xmark, color: white, size: kLargeIconSize,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}