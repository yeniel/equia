import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthService authService,
    required AnalyticsManager analyticsManager,
  })  : _authService = authService,
        _analyticsManager = analyticsManager,
        super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthService _authService;
  final AnalyticsManager _analyticsManager;

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    _analyticsManager.logEvent(LoginTapEvent());

    LoginResult? loginResult = await _authService.login(LoginProvider.google);

    if (loginResult == LoginResult.ok) {
      _analyticsManager.logEvent(LoginAnalyticsEvent(userProfile: _authService.currentProfile));
    } else {
      throw NetworkException();
    }
  }
}
