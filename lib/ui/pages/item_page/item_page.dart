import 'package:flutter/material.dart';
import 'package:squid/data/models/note_model.dart';

class ItemPage extends StatelessWidget {
  final Note _note;

  const ItemPage({super.key, required Note note}) : _note = note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(_note.title)));
  }
}
