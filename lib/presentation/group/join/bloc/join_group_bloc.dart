import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'join_group_event.dart';
part 'join_group_state.dart';

class JoinGroupBloc extends Bloc<JoinGroupEvent, JoinGroupState> {
  JoinGroupBloc({
    required UserRepository userRepository,
    required GroupsRepository groupsRepository,
    required GroupInvitationsRepository groupInvitationsRepository,
  })  : _userRepository = userRepository,
        _groupsRepository = groupsRepository,
        _groupInvitationsRepository = groupInvitationsRepository,
        super(const JoinGroupState()) {
    on<JoinGroupInitEvent>(_onGroupCreateInitEvent);
    on<JoinGroupJoinEvent>(_onJoinGroupJoinEvent);
  }

  final UserRepository _userRepository;
  final GroupsRepository _groupsRepository;
  final GroupInvitationsRepository _groupInvitationsRepository;

  Future<void> _onGroupCreateInitEvent(
    JoinGroupInitEvent event,
    Emitter<JoinGroupState> emit,
  ) async {
    var groupInvitation = await _groupInvitationsRepository.getInvitation();

    if (groupInvitation == null) {
      return emit(state);
    }

    await emit.forEach<Group?>(
      _groupsRepository.getGroup(groupId: groupInvitation.groupId),
      onData: (group) {
        if (group == null) {
          return state;
        }

        return state.copyWith(
          groupInvitation: groupInvitation,
          groupName: group.name,
        );
      },
      onError: (_, __) => state,
    );
  }

  Future<void> _onJoinGroupJoinEvent(
    JoinGroupJoinEvent event,
    Emitter<JoinGroupState> emit,
  ) async {
    var groupInvitation = await _groupInvitationsRepository.getInvitation();

    if (groupInvitation != null) {
      var acceptedGroupInvitation = GroupInvitation(
        fromUserId: groupInvitation.fromUserId,
        fromUserName: groupInvitation.fromUserName,
        toUserEmail: groupInvitation.toUserEmail,
        groupId: groupInvitation.groupId,
        status: GroupInvitationStatus.accepted,
      );

      await _groupInvitationsRepository.updateInvitation(groupInvitation: acceptedGroupInvitation);
    }

    await _userRepository.joinGroup(groupId: state.groupInvitation.groupId);

    emit(state);
  }
}
