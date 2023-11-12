part of 'onboarding_group_create_bloc.dart';

abstract class OnboardingGroupCreateEvent extends Equatable {
  const OnboardingGroupCreateEvent();
}

class OnboardingGroupCreateInitEvent extends OnboardingGroupCreateEvent {
  const OnboardingGroupCreateInitEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingCreateGroupEvent extends OnboardingGroupCreateEvent {
  const OnboardingCreateGroupEvent({required this.groupName});

  final String groupName;

  @override
  List<Object?> get props => [groupName];
}
