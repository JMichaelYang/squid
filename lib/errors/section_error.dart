import 'package:squid/errors/squid_error.dart';

class SectionError extends SquidError {
  const SectionError({required super.errorCode, super.message}) : super(namespace: ErrorNamespace.section);
}
