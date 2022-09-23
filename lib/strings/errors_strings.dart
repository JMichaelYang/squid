const Map<String, Map<String, String>> _errorStrings = {
  'auth': {
    'weak-password': 'please try again with a stronger password.',
    'email-already-in-use': 'this email is already being used, try logging in!',
    'sign-up': 'an error has occurred during sign up, please try again.',
    'user-not-found': 'no account was found for that email, try signing up!',
    'wrong-password': 'the password was incorrect, please try again.',
    'sign-in': 'an error has occurred during sign in, please try again.',
    'sign-out': 'an error has occurred during sign out, please try again.',
  },
};

String? getErrorString(String namespace, String errorCode) {
  return _errorStrings[namespace]?[errorCode];
}
