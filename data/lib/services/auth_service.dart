import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_error.dart';
import 'auth_response.dart';
import 'error_code.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService();

  UserModel? get currentUser {
    User? firebaseUser = _firebaseAuth.currentUser;

    return UserModel(id: firebaseUser?.uid ?? "", displayName: firebaseUser?.displayName, email: firebaseUser?.email);
  }

  Future<LoginResult?> login(LoginProvider? loginProvider) async {
    switch (loginProvider) {
      case LoginProvider.google:
        return _loginWithGoogle();
      default:
        return Future.value(null);
    }
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  Stream<AuthenticationStatus> get status {
    return FirebaseAuth.instance
      .userChanges()
      .map((firebaseUser) {
        if (firebaseUser == null) {
          return AuthenticationStatus.unauthenticated;
        } else {
          return AuthenticationStatus.authenticated;
        }
      });
  }

  Future<LoginResult> _loginWithGoogle() async {
    AuthResponse response = await loginWithGoogle();

    return Future.value(_resultMapper(response.success, response.error));
  }

  Future<AuthResponse> loginWithGoogle() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      try {
        AuthCredential credential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);

        return AuthResponse.success(authResult.user);
      } catch (e) {
        return AuthResponse.error(_generateError(e));
      }
    }
    return AuthResponse.error(_generateError(null));
  }


  LoginResult _resultMapper(bool success, AuthError? error) {
    if (success) {
      return LoginResult.ok;
    } else if (error != null) {
      switch (error.code) {
        case ErrorCode.accountExistsWithDifferentProvider:
          return LoginResult.accountExistsWithDifferentProvider;
        case ErrorCode.weakPassword:
          return LoginResult.weakPassword;
        case ErrorCode.emailInUse:
          return LoginResult.emailInUse;
        case ErrorCode.userNotFound:
          return LoginResult.userNotFound;
        case ErrorCode.wrongPassword:
          return LoginResult.wrongPassword;
        case ErrorCode.invalidEmail:
          return LoginResult.invalidEmail;
        case ErrorCode.networkRequestFailed:
          return LoginResult.networkRequestFailed;
        case ErrorCode.generic:
          return LoginResult.generic;
        default:
          return LoginResult.ok;
      }
    }

    return LoginResult.generic;
  }

  AuthError _generateError(e) {
    if (e is PlatformException) {
      return AuthError(_errorMapper(e.code), e.message);
    } else if (e is FirebaseAuthException) {
      return AuthError(_errorMapper(e.code), e.message);
    } else {
      return AuthError(ErrorCode.generic, e?.toString() ?? "-");
    }
  }

  ErrorCode _errorMapper(String errorCode) {
    switch (errorCode) {
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        break;
    //Google, Apple, Facebook, Twitter errors
      case "ERROR_INVALID_CREDENTIAL":
      case "invalid-credential":
        break;
      case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
      case "account-exists-with-different-credential":
        return ErrorCode.accountExistsWithDifferentProvider;
      case "ERROR_INVALID_ACTION_CODE":
      case "invalid-verification-code":
        break;
      case "invalid-verification-id":
        break;
    //Login with email
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return ErrorCode.invalidEmail;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return ErrorCode.wrongPassword;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return ErrorCode.userNotFound;
      case "ERROR_TOO_MANY_REQUESTS":
        break;
      case "ERROR_WEAK_PASSWORD":
      case "weak-password":
        return ErrorCode.weakPassword;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "email-already-in-use":
        return ErrorCode.emailInUse;
      case "ERROR_NETWORK_REQUEST_FAILED":
        return ErrorCode.networkRequestFailed;
    }
    return ErrorCode.generic;
  }
}
