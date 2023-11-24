import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'users';

  String get uid {
    return authService.currentProfile.uid;
  }

  Future<UserModel?> getUser() async {
    var response = await client.get(path: '$basePath/$uid');

    if (response == null) {
      return Future.value(null);
    }

    return UserResponse.fromJson(response).toModel();
  }

  Stream<UserModel?> getUserStream() {
    return client.getStream(path: '$basePath/$uid').map((data) {
      if (data == null) {
        return null;
      }

      return UserResponse.fromJson(data).toModel();
    });
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    await client.put(
      path: '$basePath/$uid',
      data: {
        'profile': UserProfileResponse.fromModel(userProfile).toJson(),
      },
    );
  }

  Future<void> joinGroup({required String groupId}) async {
    await client.patch(
      path: '$basePath/$uid',
      data: {
        'groupId': groupId,
      },
    );
  }
}
