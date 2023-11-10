// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInvitationResponse _$GroupInvitationResponseFromJson(
        Map<String, dynamic> json) =>
    GroupInvitationResponse(
      fromUser: json['fromUser'] as String,
      toUser: json['toUser'] as String,
      group: json['group'] as String,
    );

Map<String, dynamic> _$GroupInvitationResponseToJson(
        GroupInvitationResponse instance) =>
    <String, dynamic>{
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'group': instance.group,
    };
