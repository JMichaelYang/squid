import 'package:flutter/material.dart';
import 'package:squid/data/models/note_model.dart';

class NoteItem extends StatelessWidget {
  final Note _note;

  const NoteItem({super.key, required Note note}) : _note = note;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 64,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        color: _note.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: _note.textColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Text(
                _note.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: _note.textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                onPressed: () {},
                splashRadius: 32,
                icon: Icon(
                  Icons.expand_more,
                  size: 32,
                  color: _note.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
