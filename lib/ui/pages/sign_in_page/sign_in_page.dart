import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/ui/components/squid_background.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_form.dart';
import 'package:squid/ui/utils/routes.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          squidBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      const SizedBox(height: 36),
                      Expanded(flex: 1, child: _getTitle()),
                      const SizedBox(height: 24),
                      Expanded(flex: 1, child: _getLogo()),
                      const SizedBox(height: 24),
                    ]),
                  ),
                  const SignInForm()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignOutWrapper extends StatelessWidget {
  final Widget _child;

  const SignOutWrapper({super.key, required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) {
        if (state is AuthUnauthenticatedState) {
          Navigator.of(context).pushAndRemoveUntil(signInPageRoute(), (route) => false);
        }
      }),
      child: _child,
    );
  }
}

Widget _getTitle() {
  return const Text(
    'squid',
    style: TextStyle(
      fontFamily: 'lobster',
      fontSize: 64,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
  );
}

Widget _getLogo() {
  return SvgPicture.asset('assets/logos/squid_logo_black.svg');
}
