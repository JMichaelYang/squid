import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/data/models/note_model.dart';
import 'package:squid/ui/components/squid_background.dart';
import 'package:squid/ui/components/squid_button.dart';
import 'package:squid/ui/pages/home_page/note_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          squidBackground(),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  _getListContainer(
                    ListView.separated(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 128),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (context, index) => const NoteItem(
                        note: Note(
                          id: 'test-note',
                          title: 'To-do List',
                          color: Color(0xFFCCE9ED),
                          textColor: Colors.black,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: double.maxFinite,
                        height: 8,
                      ),
                    ),
                  ),
                  _getAddButton(() {}),
                  _getSettingsButton(() {
                    BlocProvider.of<AuthBloc>(context).add(AuthSignOutEvent());
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _getListContainer(Widget child) {
  return FractionallySizedBox(
    widthFactor: 1,
    heightFactor: 0.75,
    child: ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment(0, 0.2),
        end: Alignment.bottomCenter,
        colors: [
          Colors.black,
          Colors.transparent,
        ],
      ).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: child,
    ),
  );
}

Widget _getAddButton(void Function() onAdd) {
  return Positioned(
    left: 12,
    bottom: 12,
    child: SquidCircleButton(
      icon: const Icon(Icons.add),
      onPressed: onAdd,
    ),
  );
}

Widget _getSettingsButton(void Function() onSettings) {
  return Positioned(
    right: 12,
    bottom: 12,
    child: SquidCircleButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: onSettings,
    ),
  );
}
