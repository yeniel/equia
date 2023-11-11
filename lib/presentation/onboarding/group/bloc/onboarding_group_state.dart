part of 'onboarding_group_bloc.dart';

class OnboardingGroupState extends Equatable {
  const OnboardingGroupState({this.user = UserModel.empty});

  final UserModel user;

  OnboardingGroupState copyWith({required UserModel user}) {
    return OnboardingGroupState(user: user);
  }

  @override
  List<Object> get props => [user];
}
