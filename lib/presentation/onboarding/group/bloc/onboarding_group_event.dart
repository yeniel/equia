part of 'onboarding_group_bloc.dart';

abstract class OnboardingGroupEvent extends Equatable {
  const OnboardingGroupEvent();
}

class OnboardingGroupInitEvent extends OnboardingGroupEvent {
  const OnboardingGroupInitEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingGroupCreateEvent extends OnboardingGroupEvent {
  const OnboardingGroupCreateEvent();

  @override
  List<Object?> get props => [];
}
