import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/errors/auth_errors.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/strings/errors_strings.dart';
import 'package:squid/ui/components/squid_text_field.dart';
import 'package:squid/ui/pages/home_page/home_page.dart';
import 'package:squid/ui/components/squid_button.dart';

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

  Widget? _animatedWidget;

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    _animatedWidget ??= authBloc.state is AuthLoadingState ? _getLoading() : _getSignIn(authBloc);

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
          Widget next = _isSignUp ? _getSignUp(authBloc) : _getSignIn(authBloc);

          setState(() {
            _animatedWidget = next;
          });
        }
      },
      child: _addOverlay(
        context,
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

  Widget _getSignIn(AuthBloc bloc) {
    return Column(
      key: const ValueKey(1),
      children: [
        _getWelcomeText(false),
        const SizedBox(height: 16),
        _getEmailField(_emailController),
        const SizedBox(height: 12),
        _getPasswordField(_passwordController, _hidePassword, _setHidePassword(bloc)),
        const SizedBox(height: 12),
        _getSignInButton(_handleSignIn(bloc)),
        const SizedBox(height: 16),
        _getOrText(),
        const SizedBox(height: 16),
        _getGoogleSignInButton(_handleGoogleSignIn(bloc)),
        const SizedBox(height: 12),
        _getToggleButton(_setIsSignIn(bloc), 'sign up'),
      ],
    );
  }

  Widget _getSignUp(AuthBloc bloc) {
    return Column(
      key: const ValueKey(2),
      children: [
        _getWelcomeText(true),
        const SizedBox(height: 16),
        _getEmailField(_emailController),
        const SizedBox(height: 12),
        _getPasswordField(_passwordController, _hidePassword, _setHidePassword(bloc)),
        const SizedBox(height: 12),
        _getPasswordField(_confirmController, _hidePassword, _setHidePassword(bloc), isConfirm: true),
        const SizedBox(height: 12),
        _getSignUpButton(_handleSignUp(bloc)),
        const SizedBox(height: 16),
        _getOrText(),
        const SizedBox(height: 16),
        _getToggleButton(_setIsSignIn(bloc), 'sign in'),
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

  void Function() _setIsSignIn(AuthBloc bloc) => () {
        Widget next = _isSignUp ? _getSignIn(bloc) : _getSignUp(bloc);

        setState(() {
          _isSignUp = !_isSignUp;
          _animatedWidget = next;
        });
      };

  void Function() _setHidePassword(AuthBloc bloc) => () {
        setState(() {
          _hidePassword = !_hidePassword;
          _animatedWidget = _isSignUp ? _getSignUp(bloc) : _getSignIn(bloc);
        });
      };

  void Function() _handleSignIn(AuthBloc bloc) => () {
        bloc.add(AuthEmailSignInEvent(_emailController.text, _passwordController.text));
      };

  void Function() _handleSignUp(AuthBloc bloc) => () {
        if (_passwordController.text == _confirmController.text) {
          bloc.add(AuthEmailSignUpEvent(_emailController.text, _passwordController.text));
        } else {
          bloc.add(AuthErrorEvent(AuthErrors.notMatchingPassword));
        }
      };

  void Function() _handleGoogleSignIn(AuthBloc bloc) => () {
        bloc.add(AuthGoogleSignInEvent());
      };
}

Widget _addOverlay(BuildContext context, Widget child) {
  Color overlayColor = Theme.of(context).colorScheme.surface.withAlpha(64);

  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(color: overlayColor),
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
