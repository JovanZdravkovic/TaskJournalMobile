
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/screens/login.dart';
import 'package:task_journal_mobile/services/auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return FutureBuilder<bool>(
      future: authService.authenticate(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.data == true) {
          return child;
        } else {
          return const LoginPage();
        }
      },
    );
  }
}