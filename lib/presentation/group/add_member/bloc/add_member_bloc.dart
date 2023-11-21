import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  AddMemberBloc({
    required UserRepository userRepository,
    required GroupInvitationsRepository groupInvitationsRepository,
  })  : _userRepository = userRepository,
        _groupInvitationsRepository = groupInvitationsRepository,
        super(const AddMemberState()) {
    on<AddMemberInitEvent>(_onAddMemberInitEvent);
    on<AddMemberAddEvent>(_onOnboardingAddMemberEvent);
  }

  final UserRepository _userRepository;
  final GroupInvitationsRepository _groupInvitationsRepository;

  Future<void> _onAddMemberInitEvent(
    AddMemberInitEvent event,
    Emitter<AddMemberState> emit,
  ) async {
    emit(state);
  }

  Future<void> _onOnboardingAddMemberEvent(
    AddMemberAddEvent event,
    Emitter<AddMemberState> emit,
  ) async {
    var user = await _userRepository.getUser();

    if (user == null) {
      return emit(state);
    }

    var groupInvitation = GroupInvitation(
      fromUserId: user.profile.uid,
      fromUserName: user.profile.displayName,
      toUserEmail: event.memberEmail,
      groupId: user.groupId,
      status: GroupInvitationStatus.pending,
    );

    await _groupInvitationsRepository.createInvitation(groupInvitation: groupInvitation);

    emit(state);
  }
}
