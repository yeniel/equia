import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'users';

  Stream<UserModel> getUser() {
    if (authService.isLoggedIn) {
      String uid = authService.currentUser.uid;

      return client.getStream(path: '$basePath/$uid').map((data) => UserResponse.fromJson(data).toModel());
    } else {
      throw NetworkException();
    }
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    if (authService.isLoggedIn) {
      String uid = authService.currentUser.uid;

      await client.post(
        path: '$basePath/$uid',
        data: {
          'profile': UserProfileResponse.fromModel(userProfile).toJson(),
        },
      );
    } else {
      throw NetworkException();
    }
  }

  Future<void> joinGroup({required String groupId}) async {
    if (authService.isLoggedIn) {
      String uid = authService.currentUser.uid;

      await client.post(
        path: '$basePath/$uid',
        data: {
          'group': groupId,
        },
      );
    } else {
      throw NetworkException();
    }
  }
}