import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.id, this.displayName, this.email});

  final String id;
  final String? displayName;
  final String? email;

  static const empty = UserModel(id: "");

  @override
  List<Object> get props => [id];
}