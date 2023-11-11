import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required UserRepository userRepository,
    required GroupInvitationsRepository groupInvitationsRepository,
    required GroupsRepository groupsRepository,
    required AnalyticsManager analyticsManager,
  })  : _userRepository = userRepository,
        _groupRepository = groupsRepository,
        _groupInvitationsRepository = groupInvitationsRepository,
        _analyticsManager = analyticsManager,
        super(const OnboardingState()) {
    on<OnboardingInitEvent>(_onOnboardingInitEvent);
  }

  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;
  final GroupInvitationsRepository _groupInvitationsRepository;
  final GroupsRepository _groupRepository;

  Future<void> _onOnboardingInitEvent(OnboardingInitEvent event, Emitter<OnboardingState> emit) async {
    await emit.forEach<UserModel>(
      _userRepository.getUser(),
      onData: (user) {
        return state.copyWith(user: user);
      },
      onError: (_, __) => state,
    );
  }
}
