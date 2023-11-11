import 'package:equatable/equatable.dart';

class Group extends Equatable {
  const Group({required this.id, required this.name, required this.members});

  final String id;
  final String name;
  final List<String> members;

  static const empty = Group(id: '', name: '', members: []);

  @override
  List<Object> get props => [id, name, members];
}