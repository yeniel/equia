import 'package:firebase_auth/firebase_auth.dart';
import 'auth_error.dart';

class AuthResponse {
  AuthError? error;
  User? user;

  bool get success => user != null && error == null;

  AuthResponse.success(this.user);

  AuthResponse.error(this.error);
}