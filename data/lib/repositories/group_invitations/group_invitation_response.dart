import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_invitation_response.g.dart';

@JsonSerializable()
class GroupInvitationResponse {
  const GroupInvitationResponse({
    required this.fromUserId,
    required this.fromUserName,
    required this.toUserEmail,
    required this.groupId,
    required this.status,
  });

  factory GroupInvitationResponse.fromJson(Map<String, dynamic> json) => _$GroupInvitationResponseFromJson(json);

  final String fromUserId;
  final String fromUserName;
  final String toUserEmail;
  final String groupId;
  final String status;

  Map<String, dynamic> toJson() => _$GroupInvitationResponseToJson(this);

  factory GroupInvitationResponse.fromModel(GroupInvitation groupInvitation) {
    return GroupInvitationResponse(
        fromUserId: groupInvitation.fromUserId,
        fromUserName: groupInvitation.fromUserName,
        toUserEmail: groupInvitation.toUserEmail,
        groupId: groupInvitation.groupId,
        status: groupInvitation.status.stringValue);
  }

  GroupInvitation toModel() {
    return GroupInvitation(
      fromUserId: fromUserId,
      fromUserName: fromUserName,
      toUserEmail: toUserEmail,
      groupId: groupId,
      status: GroupInvitationStatus.values.firstWhere((element) => element.stringValue == status),
    );
  }
}
