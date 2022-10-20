import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/data/repositories/auth_repository.dart';
import 'package:squid/data/repositories/note_repository.dart';
import 'package:squid/firebase_options.dart';
import 'package:squid/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';
import 'package:squid/ui/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Dependencies().configureDefault(
    mockFirebaseAuth: true,
    mockGoogleSignIn: true,
  );

  runApp(const Squid());
}

class Squid extends StatelessWidget {
  const Squid({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepository()),
        RepositoryProvider<NoteRepository>(create: (context) => NoteRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            )..add(AuthSilentSignInEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Squid',
          theme: SquidThemes.getLightTheme(context),
          home: const SignInPage(),
        ),
      ),
    );
  }
}
