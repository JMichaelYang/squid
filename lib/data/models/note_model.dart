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

  Note.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          hex: json['hex'] as String,
          textHex: json['textHex'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hex': _hex,
      'textHex': _textHex,
    };
  }

  static Map<String, dynamic> frame({String? title, String? hex, String? textHex}) {
    return {
      if (title != null) 'title': title,
      if (hex != null) 'hex': hex,
      if (textHex != null) 'textHex': textHex,
    };
  }
}
