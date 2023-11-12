import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_group_create_event.dart';
part 'onboarding_group_create_state.dart';

class OnboardingGroupCreateBloc extends Bloc<OnboardingGroupCreateEvent, OnboardingGroupCreateState> {
  OnboardingGroupCreateBloc({
    required UserRepository userRepository,
    required GroupsRepository groupsRepository,
  })  : _userRepository = userRepository,
        _groupsRepository = groupsRepository,
        super(const OnboardingGroupCreateState()) {
    on<OnboardingGroupCreateInitEvent>(_onOnboardingGroupCreateInitEvent);
    on<OnboardingCreateGroupEvent>(_onOnboardingCreateGroupEvent);
  }

  final UserRepository _userRepository;
  final GroupsRepository _groupsRepository;

  Future<void> _onOnboardingGroupCreateInitEvent(
    OnboardingGroupCreateInitEvent event,
    Emitter<OnboardingGroupCreateState> emit,
  ) async {
    emit(state);
  }

  Future<void> _onOnboardingCreateGroupEvent(
    OnboardingCreateGroupEvent event,
    Emitter<OnboardingGroupCreateState> emit,
  ) async {
    var group = Group(
      id: '',
      name: event.groupName,
      members: [_userRepository.uid],
    );

    var createdGroup = await _groupsRepository.createGroup(group: group);
    await _userRepository.joinGroup(groupId: createdGroup.id);

    emit(state);
  }
}
