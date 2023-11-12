import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_group_info_event.dart';

part 'onboarding_group_info_state.dart';

class OnboardingGroupInfoBloc extends Bloc<OnboardingGroupInfoEvent, OnboardingGroupInfoState> {
  OnboardingGroupInfoBloc({
    required UserRepository userRepository,
    required GroupInvitationsRepository groupInvitationsRepository,
    required GroupsRepository groupsRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        super(const OnboardingGroupInfoState()) {
    on<OnboardingGroupInfoInitEvent>(_onOnboardingGroupInitEvent);
  }

  final UserRepository _userRepository;

  Future<void> _onOnboardingGroupInitEvent(
    OnboardingGroupInfoInitEvent event,
    Emitter<OnboardingGroupInfoState> emit,
  ) async {
    await emit.forEach<UserModel>(
      _userRepository.getUser(),
      onData: (user) {
        return state.copyWith(user: user);
      },
      onError: (_, __) => state,
    );
  }
}
