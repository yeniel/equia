import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupsRepository {
  const GroupsRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'groups';

  Future<void> createGroup({required Group group}) async {
    if (authService.isLoggedIn) {
      await client.post(
        path: basePath,
        data: GroupResponse.fromModel(group).toJson(),
      );
    } else {
      throw NetworkException();
    }
  }

  Stream<Group> getGroup({required String groupId}) {
    if (authService.isLoggedIn) {
      return client.getStream(path: '$basePath/$groupId').map((data) => GroupResponse.fromJson(data).toModel());
    } else {
      throw NetworkException();
    }
  }
}