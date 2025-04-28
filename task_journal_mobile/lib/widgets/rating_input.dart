import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class RatingInputWidget extends StatefulWidget{

  final void Function(int rating) setRatingCallback;

  const RatingInputWidget({super.key, required this.setRatingCallback});

  @override
  State<RatingInputWidget> createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {

  int? rating; 

  void setRating(int value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        rating != null && rating! >= 1 
          ? GestureDetector(
              child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize),
              onTap: () {
                setRating(1);
              },
            )
          : GestureDetector(
              child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
              onTap: () {
                setRating(1);
              },
            ),
        const SizedBox(
          height: kExtraSmallSpacingBoxSize,
          width: kExtraSmallSpacingBoxSize,
        ),
        rating != null && rating! >= 2 
          ? GestureDetector(
              child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kLargeIconSize),
              onTap: () {
                setRating(2);
              },
            )
          : GestureDetector(
              child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kLargeIconSize),
              onTap: () {
                setRating(2);
              },
            ),
        const SizedBox(
          height: kExtraSmallSpacingBoxSize,
          width: kExtraSmallSpacingBoxSize,
        ),
        rating != null && rating! >= 3 
          ? GestureDetector(
              child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize),
              onTap: () {
                setRating(3);
              },
            )
          : GestureDetector(
              child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
              onTap: () {
                setRating(3);
              },
            ),
      ],
    );
  }
}