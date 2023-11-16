part of 'onboarding_summary_bloc.dart';

class OnboardingSummaryState extends Equatable {
  const OnboardingSummaryState({this.user = UserModel.empty});

  final UserModel user;

  OnboardingSummaryState copyWith({required UserModel user}) {
    return OnboardingSummaryState(user: user);
  }

  @override
  List<Object> get props => [user];
}
