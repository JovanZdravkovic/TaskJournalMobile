import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget{

  final TextEditingController controller;

  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: 'Search',
      ),
    );
  }

}