import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/strings/errors_strings.dart';
import 'package:squid/ui/pages/home_page/home_page.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:squid/ui/utils/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<StatefulWidget> createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> with SingleTickerProviderStateMixin {
  bool _isSignUp = false;
  bool _hidePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  late Widget _animatedWidget;

  @override
  void initState() {
    super.initState();
    _animatedWidget = _getSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticatedState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (state is AuthErrorState) {
          SquidError error = state.error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(getErrorString(error.namespace, error.errorCode) ?? error.message ?? ''),
          ));
        } else if (state is AuthLoadingState) {
          setState(() {
            _animatedWidget = _getLoading();
          });
        } else if (state is AuthUnauthenticatedState) {
          Widget next = _isSignUp ? _getSignIn() : _getSignUp();

          setState(() {
            _isSignUp = !_isSignUp;
            _animatedWidget = next;
          });
        }
      },
      child: _addOverlay(
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _animatedWidget,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _getSignIn() {
    return Column(
      key: const ValueKey(1),
      children: [
        _getWelcomeText(false),
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
        _getToggleButton(_setIsSignIn, 'sign up'),
      ],
    );
  }

  Widget _getSignUp() {
    return Column(
      key: const ValueKey(2),
      children: [
        _getWelcomeText(true),
        const SizedBox(height: 16),
        _getEmailField(_emailController),
        const SizedBox(height: 12),
        _getPasswordField(_passwordController, _hidePassword, _setHidePassword),
        const SizedBox(height: 12),
        _getPasswordField(_confirmController, _hidePassword, _setHidePassword, isConfirm: true),
        const SizedBox(height: 12),
        _getSignUpButton(_handleSignUp),
        const SizedBox(height: 16),
        _getOrText(),
        const SizedBox(height: 16),
        _getToggleButton(_setIsSignIn, 'sign in'),
      ],
    );
  }

  Widget _getLoading() {
    return const SizedBox(
      width: double.infinity,
      height: 420,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void _setIsSignIn() {
    Widget next = _isSignUp ? _getSignIn() : _getSignUp();

    setState(() {
      _isSignUp = !_isSignUp;
      _animatedWidget = next;
    });
  }

  void _setHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
      _animatedWidget = _isSignUp ? _getSignUp() : _getSignIn();
    });
  }

  void _handleSignIn() {}

  void _handleSignUp() {}

  void _handleGoogleSignIn() {}
}

Widget _addOverlay(Widget child) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: const BoxDecoration(color: Color(0x40FFFFFF)),
        width: double.infinity,
        child: child,
      ),
    ),
  );
}

Widget _getWelcomeText(bool isSignUp) {
  if (isSignUp) {
    return const Text('welcome to squid!');
  }

  DateTime current = DateTime.now();
  String time;

  if (current.hour < 12) {
    time = 'morning';
  } else if (current.hour < 6) {
    time = 'afternoon';
  } else {
    time = 'evening';
  }

  return Text('hi, good $time!');
}

Widget _getOrText() {
  return const Text('or');
}

Widget _getEmailField(TextEditingController controller) {
  return SquidTextField(
    controller: controller,
    hintText: 'email',
    fontSize: 16,
  );
}

Widget _getPasswordField(
  TextEditingController controller,
  bool hidePassword,
  void Function() setHidePassword, {
  bool isConfirm = false,
}) {
  return SquidTextField(
    controller: controller,
    obscureText: hidePassword,
    suffixIcon: IconButton(
      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
      onPressed: setHidePassword,
    ),
    hintText: isConfirm ? 'confirm password' : 'password',
    fontSize: 16,
  );
}

Widget _getSignInButton(void Function() onSignIn) => SquidButton(handlePressed: onSignIn, text: 'sign in');

Widget _getSignUpButton(void Function() onSignUp) => SquidButton(handlePressed: onSignUp, text: 'sign up');

Widget _getGoogleSignInButton(void Function() onSignIn) => SquidButton(
      handlePressed: onSignIn,
      text: 'continue with Google',
      icon: Image.asset('assets/logos/google_logo.png'),
    );

Widget _getToggleButton(void Function() onToggle, String text) => SquidButton(handlePressed: onToggle, text: text);
