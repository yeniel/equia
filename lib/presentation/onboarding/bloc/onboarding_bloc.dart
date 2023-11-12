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
        super(const OnboardingState()) {
    on<OnboardingInitEvent>(_onOnboardingInitEvent);
  }

  final UserRepository _userRepository;

  Future<void> _onOnboardingInitEvent(OnboardingInitEvent event, Emitter<OnboardingState> emit) async {
    var user = await _userRepository.getUser();

    emit(state.copyWith(user: user));
  }
}
