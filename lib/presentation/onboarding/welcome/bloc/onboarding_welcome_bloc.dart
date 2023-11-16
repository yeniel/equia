import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_welcome_event.dart';
part 'onboarding_welcome_state.dart';

class OnboardingWelcomeBloc extends Bloc<OnboardingWelcomeEvent, OnboardingWelcomeState> {
  OnboardingWelcomeBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        super(const OnboardingWelcomeState()) {
    on<OnboardingWelcomeInitEvent>(_onOnboardingGroupInitEvent);
  }

  final UserRepository _userRepository;

  Future<void> _onOnboardingGroupInitEvent(
    OnboardingWelcomeInitEvent event,
    Emitter<OnboardingWelcomeState> emit,
  ) async {
    var user = await _userRepository.getUser();

    emit(state.copyWith(user: user));
  }
}
