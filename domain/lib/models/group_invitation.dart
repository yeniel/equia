import 'package:equatable/equatable.dart';

class GroupInvitation extends Equatable {
  const GroupInvitation({
    required this.fromUserId,
    required this.toUserEmail,
    required this.groupId,
  });

  final String fromUserId;
  final String toUserEmail;
  final String groupId;

  static const empty = GroupInvitation(fromUserId: '', toUserEmail: '', groupId: '');

  @override
  List<Object> get props => [fromUserId, toUserEmail, groupId];
}
