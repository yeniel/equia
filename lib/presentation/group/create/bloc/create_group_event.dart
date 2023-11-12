part of 'create_group_bloc.dart';

abstract class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();
}

class CreateGroupInitEvent extends CreateGroupEvent {
  const CreateGroupInitEvent();

  @override
  List<Object?> get props => [];
}

class CreateGroupCreateEvent extends CreateGroupEvent {
  const CreateGroupCreateEvent({required this.groupName});

  final String groupName;

  @override
  List<Object?> get props => [groupName];
}
