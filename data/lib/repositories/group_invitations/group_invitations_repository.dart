import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupInvitationsRepository {
  const GroupInvitationsRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'group_invitations';

  Stream<List<GroupInvitation>> getInvitations() {
    if (authService.isLoggedIn) {
      String email = authService.currentUser.profile.email;

      return client.getStreamList(path: '$basePath/$email').map((invitationsResponse) {
        return invitationsResponse.map((invitationResponse) {
          return GroupInvitationResponse.fromJson(invitationResponse).toModel();
        }).toList();
      });
    } else {
      throw NetworkException();
    }
  }

  Future<void> createInvitation({required GroupInvitation groupInvitation}) async {
    if (authService.isLoggedIn) {
      String email = authService.currentUser.profile.email;

      await client.post(
        path: '$basePath/$email',
        data: GroupInvitationResponse.fromModel(groupInvitation).toJson(),
      );
    } else {
      throw NetworkException();
    }
  }

  Future<void> joinGroup({required String groupId}) async {
    if (authService.isLoggedIn) {
      String uid = authService.currentUser.uid;

      await client.post(
        path: 'users/$uid',
        data: {
          'group': groupId,
        },
      );
    } else {
      throw NetworkException();
    }
  }
}