part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.user = UserModel.empty});

  final UserModel user;

  OnboardingState copyWith({required UserModel user}) {
    return OnboardingState(user: user);
  }

  @override
  List<Object> get props => [user];
}
