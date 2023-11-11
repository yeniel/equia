// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      profile:
          UserProfileResponse.fromJson(json['profile'] as Map<String, dynamic>),
      groupId: json['groupId'] as String?,
      groupInvitationId: json['groupInvitationId'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'groupId': instance.groupId,
      'groupInvitationId': instance.groupInvitationId,
    };
