import 'package:flutter/material.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ super.key });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: const Center(
        child: Text('Profile page'),
      ),
    );
  }
}