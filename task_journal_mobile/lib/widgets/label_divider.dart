
import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

Widget labelDivider(String label) {
  return Row(
    children: [
      const Expanded(child: Divider(color: grayDark, thickness: 2.0,)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSmallPadding),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      const Expanded(child: Divider(color: grayDark, thickness: 2.0,)),
    ],
  );
}