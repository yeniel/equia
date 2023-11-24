import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class GroupInvitation extends Equatable {
  const GroupInvitation({
    required this.fromUserId,
    required this.fromUserName,
    required this.toUserEmail,
    required this.groupId,
    required this.status,
  });

  final String fromUserId;
  final String fromUserName;
  final String toUserEmail;
  final String groupId;
  final GroupInvitationStatus status;

  static const empty = GroupInvitation(
    fromUserId: '',
    fromUserName: '',
    toUserEmail: '',
    groupId: '',
    status: GroupInvitationStatus.pending,
  );

  @override
  List<Object> get props => [fromUserId, fromUserName, toUserEmail, groupId, status];
}
