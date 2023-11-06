import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.id, this.name, this.email});

  final String id;
  final String? name;
  final String? email;

  static const empty = UserModel(id: "");

  @override
  List<Object> get props => [id];
}