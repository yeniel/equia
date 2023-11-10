import 'package:equatable/equatable.dart';

class Group extends Equatable {
  const Group({required this.id, required this.name});

  final String id;
  final String name;

  static const empty = Group(id: '', name: '');

  @override
  List<Object> get props => [id, name];
}