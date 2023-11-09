import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.profile});

  final UserProfile profile;

  String get uid => profile.uid;

  static const empty = UserModel(profile: UserProfile.empty);

  @override
  List<Object> get props => [profile];
}