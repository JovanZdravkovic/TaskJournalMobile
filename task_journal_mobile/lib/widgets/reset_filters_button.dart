import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetFiltersButtonWidget extends StatelessWidget {

  final void Function() resetFiltersCallback;

  const ResetFiltersButtonWidget({super.key, required this.resetFiltersCallback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: resetFiltersCallback, 
      icon: FaIcon(FontAwesomeIcons.arrowsRotate, color: Colors.grey.shade400,),
    );
  }

}