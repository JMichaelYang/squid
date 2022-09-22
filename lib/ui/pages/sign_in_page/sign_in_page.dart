import 'package:flutter/material.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getBackground(),
          const SafeArea(
            child: Center(
              child: SignInForm(),
            ),
          )
        ],
      ),
    );
  }
}

Widget _getBackground() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/backgrounds/water_background.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
