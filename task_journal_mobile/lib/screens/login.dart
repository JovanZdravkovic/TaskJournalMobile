import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/services/auth_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _invalidCredentialsError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kStandardPadding),
        child: Center(
          child: Container(
            decoration: containerDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: kLargeInputWidth,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(kInputBorderRadius)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kLargePadding),
                    child: Text(
                      'Log in',
                      textAlign: TextAlign.center,
                      style: largeHeadingTextStyle,
                    ),
                  ),
                ),
                Form(
                  key: _loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(kStandardPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: kMediumInputWidth,
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Enter username',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        SizedBox(
                          width: kMediumInputWidth,
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Enter password',
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                        ),
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        if(_invalidCredentialsError)
                          Text('Invalid credentials', style: dangerTextStyle), 
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        SizedBox(
                          width: kMediumInputWidth,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final result = await Provider.of<AuthService>(context, listen: false).login(
                                      { 
                                        'username': _usernameController.text, 
                                        'password': _passwordController.text 
                                      }
                                    );
                                    
                                    if (!context.mounted) return;
                                    
                                    setState(() {
                                      _invalidCredentialsError = !result;
                                    });
                                    if(result) {
                                      Navigator.pushNamed(context, '/tasks');
                                    }
                                  },
                                  child: const Text('Submit'),
                                ), 
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}