import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:squid/ui/utils/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<StatefulWidget> createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  bool _isSignUp = false;
  bool _hidePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String toggleText = _isSignUp ? 'sign in' : 'sign up';

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: const BoxDecoration(color: Color(0x40FFFFFF)),
          width: double.infinity,
          child: Column(
            children: [
              _getWelcomeText(),
              const SizedBox(height: 16),
              _getEmailField(_emailController),
              const SizedBox(height: 12),
              _getPasswordField(_passwordController, _hidePassword, _setHidePassword),
              const SizedBox(height: 12),
              _getSignInButton(_handleSignIn),
              const SizedBox(height: 16),
              _getOrText(),
              const SizedBox(height: 16),
              _getGoogleSignInButton(_handleGoogleSignIn),
              const SizedBox(height: 12),
              _getToggleButton(_setIsSignIn, toggleText),
            ],
          ),
        ),
      ),
    );
  }

  void _setIsSignIn() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  void _setHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _handleSignIn() {}

  void _handleGoogleSignIn() {}
}

Widget _getWelcomeText() {
  DateTime current = DateTime.now();
  String time;

  if (current.hour < 12) {
    time = 'morning';
  } else if (current.hour < 6) {
    time = 'afternoon';
  } else {
    time = 'evening';
  }

  return Text('hi, good $time!', style: const TextStyle(fontSize: 16));
}

Widget _getOrText() {
  return const Text('or');
}

Widget _getEmailField(TextEditingController controller) {
  return SquidTextField(
    controller: controller,
    hintText: 'email',
  );
}

Widget _getPasswordField(TextEditingController controller, bool hidePassword, void Function() setHidePassword) {
  return SquidTextField(
    controller: controller,
    obscureText: hidePassword,
    suffixIcon: IconButton(
      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
      onPressed: setHidePassword,
    ),
    hintText: 'password',
  );
}

Widget _getSignInButton(void Function() onSignIn) => SquidButton(handlePressed: onSignIn, text: 'sign in');

Widget _getGoogleSignInButton(void Function() onSignIn) => SquidButton(
      handlePressed: onSignIn,
      text: 'continue with Google',
      icon: Image.asset('assets/logos/google_logo.png'),
    );

Widget _getToggleButton(void Function() onToggle, String text) => SquidButton(handlePressed: onToggle, text: text);
