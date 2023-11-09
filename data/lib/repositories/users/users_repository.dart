import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;


  Stream<UserResponse> getUser() {
    String? uid = authService.currentUser?.id;

    if (uid == null) {
      throw NetworkException();
    }

    return client.getStream(path: 'users/$uid').map((data) => UserResponse.fromJson(data));
  }

  Future<void> updateUser({required UserModel userModel}) {
    String? uid = authService.currentUser?.id;

    if (uid == null) {
      throw NetworkException();
    }

    return client.post(path: 'users/$uid', data: UserResponse.fromUserModel(userModel).toJson());
  }
}