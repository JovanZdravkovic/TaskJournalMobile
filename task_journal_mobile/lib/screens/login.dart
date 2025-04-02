import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Provider.of<AuthService>(context, listen: false).login({ 'username': 'testuser', 'password': 'testpassword' });

            if (!context.mounted) return;

            if(result) {
              Navigator.pushNamed(context, '/tasks');
            }
          },
          child: const Text('login'),
        ),
      ),
    );
  }
}