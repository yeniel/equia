import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupsRepository {
  const GroupsRepository({required this.client});

  final ApiClient client;

  static const basePath = 'groups';

  Future<Group> createGroup({required Group group}) async {
    var newGroupJson = GroupResponse.fromModel(group).toJson();

    newGroupJson['createdAt'] = DateTime.now().toUtc().toIso8601String();

    var createdGroupJson = await client.post(
      path: basePath,
      data: newGroupJson,
    );

    return GroupResponse.fromJson(createdGroupJson).toModel();
  }

  Stream<Group> getGroup({required String groupId}) {
    return client.getStream(path: '$basePath/$groupId').map((data) => GroupResponse.fromJson(data).toModel());
  }

  Future<void> addMember({required String groupId, required String memberId}) async {
    await client.patchArray(
      path: '$basePath/$groupId',
      fieldName: 'members',
      values: [memberId],
    );
  }
}
