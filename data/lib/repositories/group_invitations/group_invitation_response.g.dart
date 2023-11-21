// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInvitationResponse _$GroupInvitationResponseFromJson(
        Map<String, dynamic> json) =>
    GroupInvitationResponse(
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String,
      toUserEmail: json['toUserEmail'] as String,
      groupId: json['groupId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$GroupInvitationResponseToJson(
        GroupInvitationResponse instance) =>
    <String, dynamic>{
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'toUserEmail': instance.toUserEmail,
      'groupId': instance.groupId,
      'status': instance.status,
    };
