import 'package:flutter/material.dart';
import 'package:task_journal_mobile/constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(kStandardPadding),
        children: [
          const Padding(
            padding: EdgeInsets.all(kStandardPadding),
            child: Text(
              'Task Journal',
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.task,
              size: kDrawerIconSize
            ),
            title: const Text('Tasks'),
            onTap: () {
              Navigator.pushNamed(context, '/tasks');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              size: kDrawerIconSize
            ),
            title: const Text('Tasks History'),
            onTap: () {
              Navigator.pushNamed(context, '/tasks_history');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: kDrawerIconSize
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}