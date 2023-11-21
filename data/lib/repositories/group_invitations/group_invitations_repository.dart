import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupInvitationsRepository {
  const GroupInvitationsRepository({required this.client, required this.userRepository});

  final ApiClient client;
  final UserRepository userRepository;

  static const basePath = 'group_invitations';

  Future<GroupInvitation?> getInvitation() async {
    try {
      var user = await userRepository.getUser();

      if (user == null) {
        return Future.value(null);
      }

      var invitationResponse = await client.get(path: '$basePath/${user.profile.email}');

      if (invitationResponse == null) {
        return Future.value(null);
      }

      return GroupInvitationResponse.fromJson(invitationResponse).toModel();
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<void> createInvitation({required GroupInvitation groupInvitation}) async {
    await client.put(
      path: '$basePath/${groupInvitation.toUserEmail}',
      data: GroupInvitationResponse.fromModel(groupInvitation).toJson(),
    );
  }

  Future<void> updateInvitation({required GroupInvitation groupInvitation}) async {
    await client.put(
      path: '$basePath/${groupInvitation.toUserEmail}',
      data: GroupInvitationResponse.fromModel(groupInvitation).toJson(),
    );
  }
}
