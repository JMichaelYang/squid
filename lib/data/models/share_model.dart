import 'package:flutter/foundation.dart';

@immutable
class Share {
  final String sharerId;
  final String shareeId;
  final String noteId;

  const Share({required this.sharerId, required this.shareeId, required this.noteId});

  Share.fromJson(Map<String, dynamic> json)
      : this(
          sharerId: json['sharerId'] as String,
          shareeId: json['shareeId'] as String,
          noteId: json['noteId'] as String,
        );

  Map<String, dynamic> toFirestore() {
    return {
      'sharerId': sharerId,
      'shareeId': shareeId,
      'noteId': noteId,
    };
  }
}
