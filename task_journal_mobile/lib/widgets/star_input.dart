import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class StarInput extends StatefulWidget {

  final bool? initValue;
  final void Function(bool value) setCallback;

  const StarInput({super.key, this.initValue, required this.setCallback});

  @override
  State<StarInput> createState() => _StarInputState();
}

class _StarInputState extends State<StarInput> {

  bool value = false;

  @override
  void initState() {
    super.initState();
    if(widget.initValue != null) {
      value = widget.initValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: value ? const FaIcon(FontAwesomeIcons.solidStar, color: starYellow, size: kLargeIconSize) : const FaIcon(FontAwesomeIcons.star, color: starYellow, size: kLargeIconSize),
      color: white,
      onPressed: () {
        setState(() {
          value = !value;
        });
        widget.setCallback(value);
      },
    );
  }
}