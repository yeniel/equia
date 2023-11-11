part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnboardingInitEvent extends OnboardingEvent {
  const OnboardingInitEvent();

  @override
  List<Object?> get props => [];
}