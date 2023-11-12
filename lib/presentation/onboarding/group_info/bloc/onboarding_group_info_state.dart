part of 'onboarding_group_info_bloc.dart';

class OnboardingGroupInfoState extends Equatable {
  const OnboardingGroupInfoState({this.user = UserModel.empty});

  final UserModel user;

  OnboardingGroupInfoState copyWith({required UserModel user}) {
    return OnboardingGroupInfoState(user: user);
  }

  @override
  List<Object> get props => [user];
}
