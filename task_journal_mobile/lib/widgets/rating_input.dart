import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class RatingInputWidget extends StatefulWidget{

  final void Function(int rating) setRatingCallback;
  final int? rating;
  final bool showPlaceholder;
  final bool showBorder;

  const RatingInputWidget({super.key, required this.setRatingCallback, required this.showPlaceholder, required this.showBorder, this.rating,});

  @override
  State<RatingInputWidget> createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSmallPadding),
      decoration: widget.showBorder ? containerDecoration : borderlessContainerDecoration,
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.rating != null && widget.rating! >= 1 
                ? GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize),
                    onTap: () {
                      widget.setRatingCallback(1);
                    },
                  )
                : GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
                    onTap: () {
                      widget.setRatingCallback(1);
                    },
                  ),
              const SizedBox(
                height: kExtraSmallSpacingBoxSize,
                width: kExtraSmallSpacingBoxSize,
              ),
              widget.rating != null && widget.rating! >= 2 
                ? GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kLargeIconSize),
                    onTap: () {
                      widget.setRatingCallback(2);
                    },
                  )
                : GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kLargeIconSize),
                    onTap: () {
                      widget.setRatingCallback(2);
                    },
                  ),
              const SizedBox(
                height: kExtraSmallSpacingBoxSize,
                width: kExtraSmallSpacingBoxSize,
              ),
              widget.rating != null && widget.rating! >= 3 
                ? GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kSmallIconSize),
                    onTap: () {
                      widget.setRatingCallback(3);
                    },
                  )
                : GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kSmallIconSize),
                    onTap: () {
                      widget.setRatingCallback(3);
                    },
                  ),
            ],
          ),
          if(widget.rating == null && widget.showPlaceholder) ...[
            const SizedBox(
              height: kExtraSmallSpacingBoxSize,
              width: kExtraSmallSpacingBoxSize,
            ),
            const Text('Select rating'),
          ]
        ],
      ),
    );
  }
}