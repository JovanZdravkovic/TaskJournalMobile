import 'dart:async';

import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget{

  final TextEditingController controller;
  final void Function() onChangeCallback;

  const SearchBarWidget({super.key, required this.controller, required this.onChangeCallback});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: 'Search',
      ),
      onChanged: (value) {
        if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 300), () {
            widget.onChangeCallback();
        });
      },
    );
  }
}