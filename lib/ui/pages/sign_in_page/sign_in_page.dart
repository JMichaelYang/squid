import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                children: [
                  Expanded(flex: 1, child: Align(alignment: Alignment.bottomCenter, child: _getTitle())),
                  const SizedBox(height: 48),
                  Expanded(flex: 1, child: _getLogo()),
                  const SizedBox(height: 48),
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
