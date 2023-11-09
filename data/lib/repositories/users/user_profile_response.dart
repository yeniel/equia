import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  const UserProfileResponse({
    required this.uid,
    this.displayName,
    this.email,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);

  final String uid;
  final String? displayName;
  final String? email;

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  factory UserProfileResponse.fromUserProfile(UserProfile userProfile) {
    return UserProfileResponse(
      uid: userProfile.uid,
      displayName: userProfile.displayName,
      email: userProfile.email,
    );
  }
}