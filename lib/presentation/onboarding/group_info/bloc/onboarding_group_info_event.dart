part of 'onboarding_group_info_bloc.dart';

abstract class OnboardingGroupInfoEvent extends Equatable {
  const OnboardingGroupInfoEvent();
}

class OnboardingGroupInfoInitEvent extends OnboardingGroupInfoEvent {
  const OnboardingGroupInfoInitEvent();

  @override
  List<Object?> get props => [];
}
