import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupsRepository {
  const GroupsRepository({required this.client});

  final ApiClient client;

  static const basePath = 'groups';

  Future<void> createGroup({required Group group}) async {
    await client.post(
      path: basePath,
      data: GroupResponse.fromModel(group).toJson(),
    );
  }

  Stream<Group> getGroup({required String groupId}) {
    return client.getStream(path: '$basePath/$groupId').map((data) => GroupResponse.fromJson(data).toModel());
  }
}