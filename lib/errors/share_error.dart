import 'package:squid/errors/squid_error.dart';

class ShareError extends SquidError {
  const ShareError({required super.errorCode, super.message}) : super(namespace: ErrorNamespace.share);
}
