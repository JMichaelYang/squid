import 'package:flutter/material.dart';
import 'package:squid/ui/pages/home_page/home_page.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';

Route signInPageRoute() {
  return PageRouteBuilder(
    pageBuilder: ((context, animation, secondaryAnimation) => const SignInPage()),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 1;
      const double end = 0;
      const Curve curve = Curves.ease;

      return FadeTransition(
        opacity: animation.drive(Tween(begin: begin, end: end).chain(CurveTween(curve: curve))),
        child: child,
      );
    },
  );
}

Route homePageRoute() {
  return PageRouteBuilder(
    pageBuilder: ((context, animation, secondaryAnimation) => const HomePage()),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 1;
      const double end = 0;
      const Curve curve = Curves.ease;

      return FadeTransition(
        opacity: animation.drive(Tween(begin: begin, end: end).chain(CurveTween(curve: curve))),
        child: child,
      );
    },
  );
}
