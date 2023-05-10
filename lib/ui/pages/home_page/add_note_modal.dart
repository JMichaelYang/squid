import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/note/note_bloc.dart';
import 'package:squid/blocs/note/note_event.dart';
import 'package:squid/blocs/note/note_state.dart';
import 'package:squid/ui/components/squid_text_field.dart';

class AddNoteModal extends StatefulWidget {
  const AddNoteModal({super.key});

  @override
  State<StatefulWidget> createState() => AddNoteModalState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<NoteBloc>(context),
                child: const AddNoteModal(),
              )
            ],
          ),
        );
      },
    );
  }
}

class AddNoteModalState extends State<AddNoteModal> {
  bool _entryEnabled = true;

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteAddedState || state is NoteErrorState) {
          Navigator.pop(context);
        } else if (state is NotesLoadingState) {
          setState(() {
            _entryEnabled = false;
          });
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              _getTitleField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getAddButton(),
                  _getCancelButton(context),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _getTitleField() {
    return SquidTextField(
      controller: _nameController,
      hintText: "title",
    );
  }

  Widget _getAddButton() {
    return TextButton(
      onPressed: _entryEnabled ? _addNote : null,
      child: _entryEnabled ? const Text("create") : const CircularProgressIndicator(),
    );
  }

  void _addNote() {
    BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
      _nameController.text,
      Colors.black,
      Colors.white,
    ));
  }

  Widget _getCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text("cancel"),
    );
  }
}
