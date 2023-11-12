import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthService authService,
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _authService = authService,
        _userRepository = userRepository,
        _analyticsManager = analyticsManager,
        super(const AppState.unknown()) {
    on<AppStatusChanged>(_onAuthenticationStatusChanged);

    _authenticationStatusSubscription = _authService.status.listen(
      (status) => add(AppStatusChanged(status)),
    );
  }

  final AuthService _authService;
  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;
  late StreamSubscription<AppAuthStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AppStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    switch (event.status) {
      case AppAuthStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
      case AppAuthStatus.authenticated:
        if (_authService.isLoggedIn) {
          var currentUserProfile = _authService.currentProfile;

          _userRepository.updateUserProfile(userProfile: currentUserProfile);
          _analyticsManager.setUserId(currentUserProfile.uid);

          await emit.forEach<UserModel>(
            _userRepository.getUserStream(),
            onData: (user) {
              if (user.hasGroup) {
                return const AppState.authenticated();
              } else {
                return const AppState.authenticatedNewUser();
              }
            },
            onError: (_, __) => state,
          );
        } else {
          return emit(const AppState.unauthenticated());
        }
      default:
        return emit(const AppState.unknown());
    }
  }
}
