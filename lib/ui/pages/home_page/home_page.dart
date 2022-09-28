import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:squid/ui/utils/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            void handlePressed() {
              BlocProvider.of<AuthBloc>(context).add(AuthSignOutEvent());
            }

            if (state is AuthAuthenticatedState) {
              return Center(
                child: Column(
                  children: [
                    Text('Hello ${state.user.displayName}'),
                    const SizedBox(height: 24),
                    SquidButton(
                      handlePressed: handlePressed,
                      text: 'sign out',
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
