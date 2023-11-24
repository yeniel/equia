import 'package:equatable/equatable.dart';

class Chore extends Equatable {
  const Chore({
    required this.id,
    required this.name,
    required this.comments,
    required this.duration,
    required this.assignedTo,
    required this.createdBy,
  });

  final String id;
  final String name;
  final String comments;
  final Duration duration;
  final String assignedTo;
  final String createdBy;

  static const empty = Chore(
    id: '',
    name: '',
    comments: '',
    duration: Duration.zero,
    assignedTo: '',
    createdBy: '',
  );

  @override
  List<Object> get props => [id, name, comments, duration, assignedTo, createdBy];
}
