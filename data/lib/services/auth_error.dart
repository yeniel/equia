import 'error_code.dart';

class AuthError {
  final ErrorCode code;
  final String? message;

  AuthError(this.code, this.message);
}