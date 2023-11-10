import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_invitation_response.g.dart';

@JsonSerializable()
class GroupInvitationResponse {
  const GroupInvitationResponse({
    required this.fromUser,
    required this.toUser,
    required this.group,
  });

  factory GroupInvitationResponse.fromJson(Map<String, dynamic> json) => _$GroupInvitationResponseFromJson(json);

  final String fromUser;
  final String toUser;
  final String group;

  Map<String, dynamic> toJson() => _$GroupInvitationResponseToJson(this);

  factory GroupInvitationResponse.fromModel(GroupInvitation groupInvitation) {
    return GroupInvitationResponse(
      fromUser: groupInvitation.fromUser,
      toUser: groupInvitation.toUser,
      group: groupInvitation.group,
    );
  }

  GroupInvitation toModel() {
    return GroupInvitation(
      fromUser: fromUser,
      toUser: toUser,
      group: group,
    );
  }
}