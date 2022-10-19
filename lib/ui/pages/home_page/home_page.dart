import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/ui/components/squid_background.dart';
import 'package:squid/ui/pages/home_page/buttons.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          squidBackground(),
          SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: ((context, state) {
                if (state is AuthUnauthenticatedState) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                    (route) => false,
                  );
                }
              }),
              builder: (context, state) {
                if (state is AuthAuthenticatedState) {
                  return Stack(
                    children: [
                      getAddButton(context, () {}),
                      getSettingsButton(context, () {
                        BlocProvider.of<AuthBloc>(context).add(AuthSignOutEvent());
                      }),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
