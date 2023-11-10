import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  const UserResponse({
    required this.profile
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  final UserProfileResponse profile;

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  factory UserResponse.fromModel(UserModel userModel) {
    return UserResponse(
      profile: UserProfileResponse(
        uid: userModel.profile.uid,
        displayName: userModel.profile.displayName,
        email: userModel.profile.email,
      )
    );
  }

  UserModel toModel() {
    return UserModel(
      profile: profile.toModel(),
    );
  }
}