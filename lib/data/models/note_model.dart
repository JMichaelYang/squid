import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Note {
  final String id;
  final String title;
  final String _hex;
  Color get color => Color(int.parse(_hex, radix: 16));
  final String _textHex;
  Color get textColor => Color(int.parse(_textHex, radix: 16));

  const Note({
    required this.id,
    required this.title,
    required hex,
    required textHex,
  })  : _hex = hex,
        _textHex = textHex;

  factory Note.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? data = snapshot.data();
    return Note(
      id: data?['id'],
      title: data?['title'],
      hex: data?['hex'],
      textHex: data?['textHex'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'hex': _hex,
      'textHex': _textHex,
    };
  }
}
