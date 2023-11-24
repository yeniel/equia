import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chore_response.g.dart';

@JsonSerializable()
class ChoreResponse {
  const ChoreResponse({
    required this.id,
    required this.type,
    required this.name,
    required this.comments,
    required this.duration,
    required this.assignedTo,
    required this.createdBy,
    required this.weekdays,
  });

  factory ChoreResponse.fromJson(Map<String, dynamic> json) => _$ChoreResponseFromJson(json);

  final String id;
  final ChoreTypeResponse type;
  final String name;
  final String comments;
  final Duration duration;
  final String assignedTo;
  final String createdBy;
  final List<int> weekdays;

  Map<String, dynamic> toJson() => _$ChoreResponseToJson(this);

  factory ChoreResponse.fromModel(Chore chore) {
    switch (chore) {
      case WeeklyChore weeklyChore:
        return ChoreResponse(
          id: weeklyChore.id,
          type: ChoreTypeResponse.weekly,
          name: weeklyChore.name,
          comments: weeklyChore.comments,
          duration: weeklyChore.duration,
          assignedTo: weeklyChore.assignedTo,
          createdBy: weeklyChore.createdBy,
          weekdays: weeklyChore.weekdays,
        );
      default:
        return ChoreResponse(
          id: chore.id,
          type: ChoreTypeResponse.weekly,
          name: chore.name,
          comments: chore.comments,
          duration: chore.duration,
          assignedTo: chore.assignedTo,
          createdBy: chore.createdBy,
          weekdays: [],
        );
    }
  }

  Chore toModel() {
    switch (type) {
      case ChoreTypeResponse.weekly:
        return WeeklyChore(
          id: id,
          name: name,
          comments: comments,
          duration: duration,
          assignedTo: assignedTo,
          createdBy: createdBy,
          weekdays: weekdays,
        );
      default:
        return Chore(
          id: id,
          name: name,
          comments: comments,
          duration: duration,
          assignedTo: assignedTo,
          createdBy: createdBy,
        );
    }
  }
}
