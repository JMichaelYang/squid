import 'package:squid/errors/squid_error.dart';

class NoteError extends SquidError {
  // Get notes errors.
  static const SquidError notFound = NoteError(errorCode: 'not-found');
  static const SquidError unauthorized = NoteError(errorCode: 'unauthorized');

  const NoteError({required super.errorCode, super.message}) : super(namespace: ErrorNamespace.note);
}
