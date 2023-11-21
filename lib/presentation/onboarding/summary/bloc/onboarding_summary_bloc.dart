import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_summary_event.dart';
part 'onboarding_summary_state.dart';

class OnboardingSummaryBloc extends Bloc<OnboardingSummaryEvent, OnboardingSummaryState> {
  OnboardingSummaryBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        super(const OnboardingSummaryState()) {
    on<OnboardingSummaryInitEvent>(_onOnboardingGroupInitEvent);
  }

  final UserRepository _userRepository;

  Future<void> _onOnboardingGroupInitEvent(
    OnboardingSummaryInitEvent event,
    Emitter<OnboardingSummaryState> emit,
  ) async {
    var user = await _userRepository.getUser();

    if (user == null) {
      return emit(state);
    } else {
      emit(state.copyWith(user: user));
    }
  }
}
