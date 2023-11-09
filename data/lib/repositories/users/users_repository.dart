import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;


  Stream<UserResponse> getUser() {
    String? uid = authService.currentUser?.uid;

    if (uid == null) {
      throw NetworkException();
    }

    return client.getStream(path: 'users/$uid').map((data) => UserResponse.fromJson(data));
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    String? uid = authService.currentUser?.uid;

    if (uid == null) {
      throw NetworkException();
    }

    await client.post(
        path: 'users/$uid',
        data: {
          'profile': UserProfileResponse.fromUserProfile(userProfile).toJson(),
        },
    );
  }
}