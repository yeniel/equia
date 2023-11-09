import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({required this.uid, this.displayName, this.email});

  final String uid;
  final String? displayName;
  final String? email;

  static const empty = UserProfile(uid: "");

  @override
  List<Object> get props => [uid];
}