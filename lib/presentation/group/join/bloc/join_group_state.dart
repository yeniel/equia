part of 'join_group_bloc.dart';

class JoinGroupState extends Equatable {
  const JoinGroupState({this.groupInvitation = GroupInvitation.empty, this.groupName = ''});

  final GroupInvitation groupInvitation;
  final String groupName;

  JoinGroupState copyWith({groupInvitation, groupName}) {
    return JoinGroupState(
      groupInvitation: groupInvitation ?? this.groupInvitation,
      groupName: groupName ?? this.groupName,
    );
  }

  @override
  List<Object> get props => [];
}
