import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/note/note_bloc.dart';
import 'package:squid/data/repositories/note_repository.dart';
import 'package:squid/ui/pages/home_page/home_page.dart';
import 'package:squid/ui/pages/home_page/item_page.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';

FadeTransition _getTransition(Animation animation, Widget child) {
  double begin = 0;
  double end = 1;
  Curve curve = Curves.ease;

  return FadeTransition(
    opacity: animation.drive(Tween(begin: begin, end: end).chain(CurveTween(curve: curve))),
    child: child,
  );
}

Route signInPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SignInPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => _getTransition(animation, child),
  );
}

Route homePageRoute(String userId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<NoteBloc>(
      child: const SignOutWrapper(child: HomePage()),
      create: (context) => NoteBloc(userId: userId, noteRepository: RepositoryProvider.of<NoteRepository>(context)),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => _getTransition(animation, child),
  );
}

Route itemPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<NoteBloc>.value(
      value: BlocProvider.of<NoteBloc>(context),
      child: const SignOutWrapper(child: ItemPage()),
    ),
  );
}
