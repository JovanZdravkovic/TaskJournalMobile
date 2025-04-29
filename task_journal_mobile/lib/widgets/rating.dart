import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class RatingWidget extends StatelessWidget {

  final int rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        rating >= 1 ? const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize) : const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
        const SizedBox(
          height: kExtraSmallSpacingBoxSize,
          width: kExtraSmallSpacingBoxSize,
        ),
        rating >= 2 ? const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kLargeIconSize) : const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kLargeIconSize),
        const SizedBox(
          height: kExtraSmallSpacingBoxSize,
          width: kExtraSmallSpacingBoxSize,
        ),
        rating >= 3 ? const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize) : const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
      ],
    );
  }

}