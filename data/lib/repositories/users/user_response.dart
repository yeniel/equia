import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  const UserResponse({
    required this.uid,
    this.displayName,
    this.email,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  final String uid;
  final String? displayName;
  final String? email;

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  factory UserResponse.fromUserModel(UserModel userModel) {
    return UserResponse(
      uid: userModel.id,
      displayName: userModel.displayName,
      email: userModel.email,
    );
  }
}