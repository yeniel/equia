import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_invitation_response.g.dart';

@JsonSerializable()
class GroupInvitationResponse {
  const GroupInvitationResponse({
    required this.fromUserId,
    required this.toUserEmail,
    required this.groupId,
  });

  factory GroupInvitationResponse.fromJson(Map<String, dynamic> json) => _$GroupInvitationResponseFromJson(json);

  final String fromUserId;
  final String toUserEmail;
  final String groupId;

  Map<String, dynamic> toJson() => _$GroupInvitationResponseToJson(this);

  factory GroupInvitationResponse.fromModel(GroupInvitation groupInvitation) {
    return GroupInvitationResponse(
      fromUserId: groupInvitation.fromUserId,
      toUserEmail: groupInvitation.toUserEmail,
      groupId: groupInvitation.groupId,
    );
  }

  GroupInvitation toModel() {
    return GroupInvitation(
      fromUserId: fromUserId,
      toUserEmail: toUserEmail,
      groupId: groupId,
    );
  }
}
