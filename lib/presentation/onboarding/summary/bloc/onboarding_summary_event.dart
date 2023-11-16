part of 'onboarding_summary_bloc.dart';

abstract class OnboardingSummaryEvent extends Equatable {
  const OnboardingSummaryEvent();
}

class OnboardingSummaryInitEvent extends OnboardingSummaryEvent {
  const OnboardingSummaryInitEvent();

  @override
  List<Object?> get props => [];
}
