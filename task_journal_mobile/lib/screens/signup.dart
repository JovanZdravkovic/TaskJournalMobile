import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/services/auth_service.dart';
import 'package:task_journal_mobile/utils/signup_form_validators.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({ super.key });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _signupFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  String? confirmPasswordValidator(String? confirmPassword) {
    if(confirmPassword == _passwordController.text) {
      return null;
    }
    return 'Passwords don\'t match';
  } 

  void signup() async {
    if(_signupFormKey.currentState!.validate()) {
      final result = await Provider.of<AuthService>(context, listen: false).signup(
        { 
          'username': _usernameController.text,
          'email': _emailController.text, 
          'password': _passwordController.text, 
        }
      );
      
      if (!context.mounted) return;
      
      if(result != '') {
        Navigator.pushNamed(context, '/login');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
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
                    padding: const EdgeInsets.all(kStandardPadding),
                    child: Text(
                      'Sign up',
                      textAlign: TextAlign.center,
                      style: largeHeadingTextStyle,
                    ),
                  ),
                ),
                Form(
                  key: _signupFormKey,
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
                            validator: SignupFormValidators.username,
                          ),
                        ),
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        SizedBox(
                          width: kMediumInputWidth,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Enter email',
                            ),
                            validator: SignupFormValidators.email,
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
                        SizedBox(
                          width: kMediumInputWidth,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            validator: confirmPasswordValidator,
                            decoration: const InputDecoration(
                              labelText: 'Confirm password',
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
                        SizedBox(
                          width: kMediumInputWidth,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: signup,
                                  child: const Text('Submit'),
                                ), 
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Already have an account?'),
                            const SizedBox(
                              height: kExtraSmallSpacingBoxSize,
                              width: kExtraSmallSpacingBoxSize,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text('Log in', style: hyperlinkTextStyle),
                            )
                          ],
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