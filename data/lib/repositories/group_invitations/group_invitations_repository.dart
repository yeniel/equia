import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupInvitationsRepository {
  const GroupInvitationsRepository({required this.client, required this.userRepository});

  final ApiClient client;
  final UserRepository userRepository;

  static const basePath = 'group_invitations';

  Stream<List<GroupInvitation>> getInvitations() {
    return userRepository.getUser().asyncExpand((user) {
      return client.getStreamList(path: '$basePath/${user.profile.email}').map((invitationsResponse) {
        return invitationsResponse.map((invitationResponse) {
          return GroupInvitationResponse.fromJson(invitationResponse).toModel();
        }).toList();
      });
    });
  }

  Future<void> createInvitation({required GroupInvitation groupInvitation}) async {
    String email = (await userRepository.getUser().last).profile.email;

    await client.post(
      path: '$basePath/$email',
      data: GroupInvitationResponse.fromModel(groupInvitation).toJson(),
    );
  }

  Future<void> joinGroup({required String groupId}) async {
    String uid = await userRepository.uid;

    await client.post(
      path: 'users/$uid',
      data: {
        'group': groupId,
      },
    );
  }
}