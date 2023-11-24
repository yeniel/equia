import 'package:domain/domain.dart';

class WeeklyChore extends Chore {
  const WeeklyChore({
    required String id,
    required String name,
    required String comments,
    required Duration duration,
    required String assignedTo,
    required String createdBy,
    required this.weekdays,
  }) : super(
          id: id,
          name: name,
          comments: comments,
          duration: duration,
          assignedTo: assignedTo,
          createdBy: createdBy,
        );

  final List<int> weekdays;

  static const empty = WeeklyChore(
    id: '',
    name: '',
    comments: '',
    duration: Duration.zero,
    assignedTo: '',
    createdBy: '',
    weekdays: [],
  );
}
