part of 'join_group_bloc.dart';

abstract class JoinGroupEvent extends Equatable {
  const JoinGroupEvent();
}

class JoinGroupInitEvent extends JoinGroupEvent {
  const JoinGroupInitEvent();

  @override
  List<Object?> get props => [];
}

class JoinGroupJoinEvent extends JoinGroupEvent {
  const JoinGroupJoinEvent();

  @override
  List<Object?> get props => [];
}
