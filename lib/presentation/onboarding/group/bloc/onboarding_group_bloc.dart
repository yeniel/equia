import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_group_event.dart';

part 'onboarding_group_state.dart';

class OnboardingGroupBloc extends Bloc<OnboardingGroupEvent, OnboardingGroupState> {
  OnboardingGroupBloc({
    required UserRepository userRepository,
    required GroupInvitationsRepository groupInvitationsRepository,
    required GroupsRepository groupsRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        _groupRepository = groupsRepository,
        _groupInvitationsRepository = groupInvitationsRepository,
        _analyticsManager = analyticsManager,
        super(const OnboardingGroupState()) {
    on<OnboardingGroupInitEvent>(_onOnboardingGroupInitEvent);
  }

  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;
  final GroupInvitationsRepository _groupInvitationsRepository;
  final GroupsRepository _groupRepository;

  Future<void> _onOnboardingGroupInitEvent(OnboardingGroupInitEvent event, Emitter<OnboardingGroupState> emit) async {
    await emit.forEach<UserModel>(
      _userRepository.getUser(),
      onData: (user) {
        return state.copyWith(user: user);
      },
      onError: (_, __) => state,
    );
  }
}
