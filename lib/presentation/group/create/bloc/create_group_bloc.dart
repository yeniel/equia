import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc({
    required UserRepository userRepository,
    required GroupsRepository groupsRepository,
  })  : _userRepository = userRepository,
        _groupsRepository = groupsRepository,
        super(const CreateGroupState()) {
    on<CreateGroupInitEvent>(_onGroupCreateInitEvent);
    on<CreateGroupCreateEvent>(_onCreateGroupCreateEvent);
  }

  final UserRepository _userRepository;
  final GroupsRepository _groupsRepository;

  Future<void> _onGroupCreateInitEvent(
    CreateGroupInitEvent event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(state);
  }

  Future<void> _onCreateGroupCreateEvent(
    CreateGroupCreateEvent event,
    Emitter<CreateGroupState> emit,
  ) async {
    var group = Group(
      id: '',
      name: event.groupName,
      members: [_userRepository.uid],
    );

    var createdGroup = await _groupsRepository.createGroup(group: group);
    await _userRepository.joinGroup(groupId: createdGroup.id);

    emit(state);
  }
}
