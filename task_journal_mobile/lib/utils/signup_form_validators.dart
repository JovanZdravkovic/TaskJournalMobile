import 'package:email_validator/email_validator.dart';

class SignupFormValidators {

  static String? username(String? username) {
    if(username != null && username.isNotEmpty) {
      if(username.length <= 50) {
        return null;
      } else {
        return 'Username must be shorter than 50 characters';
      }
    }
    return 'Username cannot be empty';
  } 

  static String? email(String? email) {
    if(email != null && email.isNotEmpty) {
      if(EmailValidator.validate(email)) {
        return null;
      } else {
        return 'Invalid email format';
      }
    }
    return 'Email cannot be empty';
  } 

}