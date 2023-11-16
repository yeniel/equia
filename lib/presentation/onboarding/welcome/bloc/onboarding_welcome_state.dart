part of 'onboarding_welcome_bloc.dart';

class OnboardingWelcomeState extends Equatable {
  const OnboardingWelcomeState({this.user = UserModel.empty});

  final UserModel user;

  OnboardingWelcomeState copyWith({required UserModel user}) {
    return OnboardingWelcomeState(user: user);
  }

  @override
  List<Object> get props => [user];
}
