import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'users';

  Future<String> get uid async {
    return (await getUser().last).profile.uid;
  }

  Future<UserModel> get currentUser async {
    return getUser().last;
  }

  Stream<UserModel> getUser() {
    String uid = authService.currentProfile.uid;

    return client.getStream(path: '$basePath/$uid').map((data) => UserResponse.fromJson(data).toModel());
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    String uid = authService.currentProfile.uid;

    await client.post(
      path: '$basePath/$uid',
      data: {
        'profile': UserProfileResponse.fromModel(userProfile).toJson(),
      },
    );
  }

  Future<void> joinGroup({required String groupId}) async {
    String uid = authService.currentProfile.uid;

    await client.post(
      path: '$basePath/$uid',
      data: {
        'group': groupId,
      },
    );
  }
}