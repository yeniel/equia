// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInvitationResponse _$GroupInvitationResponseFromJson(Map<String, dynamic> json) => GroupInvitationResponse(
      fromUserId: json['fromUser'] as String,
      toUserEmail: json['toUser'] as String,
      groupId: json['group'] as String,
    );

Map<String, dynamic> _$GroupInvitationResponseToJson(GroupInvitationResponse instance) => <String, dynamic>{
      'fromUser': instance.fromUserId,
      'toUser': instance.toUserEmail,
      'group': instance.groupId,
    };
