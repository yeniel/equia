import 'package:equatable/equatable.dart';

class GroupInvitation extends Equatable {
  const GroupInvitation({
    required this.fromUser,
    required this.toUser,
    required this.group,
  });


  final String fromUser;
  final String toUser;
  final String group;

  static const empty = GroupInvitation(fromUser: '', toUser: '', group: '');

  @override
  List<Object> get props => [fromUser, toUser, group];
}