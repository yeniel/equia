import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({required this.uid, required this.displayName, required this.email});

  final String uid;
  final String displayName;
  final String email;

  static const empty = UserProfile(uid: "", displayName: "", email: "");

  @override
  List<Object> get props => [uid];
}