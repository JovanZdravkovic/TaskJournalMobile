import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class SnackBarWidget {
  
  static SnackBar success(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check, 
            color: white, 
            size: kLargeIconSize,
          ),
          const SizedBox(
            width: kSmallSpacingBoxSize,
          ),
          Text(
            message, 
            style: cardTextStyle,
          ),
        ],
      ),
      backgroundColor: primary,
      showCloseIcon: true,
      duration: const Duration(seconds: kSnackBarDuration),
    );
  }

  static SnackBar error(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline, 
            color: white, 
            size: kLargeIconSize,
          ),
          const SizedBox(
            width: kSmallSpacingBoxSize,
          ),
          Text(
            message, 
            style: cardTextStyle,
          ),
        ],
      ),
      backgroundColor: danger,
      showCloseIcon: true,
      duration: const Duration(seconds: kSnackBarDuration),
    );
  }

}