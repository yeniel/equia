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
    required GroupInvitationsRepository groupInvitationsRepository,
    required AnalyticsManager analyticsManager,
  })  : _authService = authService,
        _userRepository = userRepository,
        _groupInvitationsRepository = groupInvitationsRepository,
        _analyticsManager = analyticsManager,
        super(const AppState(authStatus: AppAuthStatus.unknown)) {
    on<AppStatusChanged>(_onAuthenticationStatusChanged);

    _authenticationStatusSubscription = _authService.status.listen(
      (status) => add(AppStatusChanged(status)),
    );
  }

  final AuthService _authService;
  final UserRepository _userRepository;
  final GroupInvitationsRepository _groupInvitationsRepository;
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
        return emit(state.copyWith(
          authStatus: AppAuthStatus.unauthenticated,
        ));
      case AppAuthStatus.authenticated:
        if (_authService.isLoggedIn) {
          var currentUserProfile = _authService.currentProfile;

          _userRepository.updateUserProfile(userProfile: currentUserProfile);
          _analyticsManager.setUserId(currentUserProfile.uid);

          var user = await _userRepository.getUser();

          if (user != null) {
            if (user.hasGroup) {
              emit(state.copyWith(
                authStatus: AppAuthStatus.authenticated,
                initialRoute: InitialRoute.home,
              ));
            } else {
              var groupInvitation = await _groupInvitationsRepository.getInvitation();

              if (groupInvitation != null && groupInvitation.status == GroupInvitationStatus.pending) {
                emit(state.copyWith(
                  authStatus: AppAuthStatus.authenticated,
                  initialRoute: InitialRoute.invitation,
                ));
              } else {
                emit(state.copyWith(
                  authStatus: AppAuthStatus.authenticated,
                  initialRoute: InitialRoute.onboarding,
                ));
              }
            }
          }
        }

        break;
      default:
        return emit(state.copyWith(authStatus: AppAuthStatus.unknown));
    }
  }
}
