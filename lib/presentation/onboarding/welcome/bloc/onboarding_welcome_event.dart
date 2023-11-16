part of 'onboarding_welcome_bloc.dart';

abstract class OnboardingWelcomeEvent extends Equatable {
  const OnboardingWelcomeEvent();
}

class OnboardingWelcomeInitEvent extends OnboardingWelcomeEvent {
  const OnboardingWelcomeInitEvent();

  @override
  List<Object?> get props => [];
}
