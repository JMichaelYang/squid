const Map<String, Map<String, String>> _errorStrings = {
  'auth': {
    'weak-password': 'Please try again with a stronger password.',
    'email-already-in-use': 'This email is already being used, try logging in!',
    'not-matching-password': 'Please confirm that you\'ve entered the same password twice.',
    'sign-up': 'An error has occurred during sign up, please try again.',
    'user-not-found': 'No account was found for that email, try signing up!',
    'wrong-password': 'The password was incorrect, please try again.',
    'sign-in': 'An error has occurred during sign in, please try again.',
    'sign-out': 'An error has occurred during sign out, please try again.',
  },
};

String? getErrorString(String namespace, String errorCode) {
  return _errorStrings[namespace]?[errorCode];
}
