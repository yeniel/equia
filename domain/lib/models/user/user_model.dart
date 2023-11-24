import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.profile, required this.groupId, required this.groupInvitationId});

  final UserProfile profile;
  final String groupId;
  final String groupInvitationId;

  String get uid => profile.uid;
  bool get hasGroup => groupId.isNotEmpty;

  static const empty = UserModel(profile: UserProfile.empty, groupId: "", groupInvitationId: "");

  @override
  List<Object> get props => [profile, groupId, groupInvitationId];
}