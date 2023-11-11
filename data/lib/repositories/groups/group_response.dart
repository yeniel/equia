import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_response.g.dart';

@JsonSerializable()
class GroupResponse {
  const GroupResponse({
    required this.id,
    required this.name,
    required this.members,
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) => _$GroupResponseFromJson(json);

  final String id;
  final String name;
  final List<String> members;

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  factory GroupResponse.fromModel(Group group) {
    return GroupResponse(
      id: group.id,
      name: group.name,
      members: group.members,
    );
  }

  Group toModel() {
    return Group(
      id: id,
      name: name,
      members: members,
    );
  }
}