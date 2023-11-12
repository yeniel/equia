import 'package:data/data.dart';
import 'package:domain/domain.dart';

class GroupInvitationsRepository {
  const GroupInvitationsRepository({required this.client, required this.userRepository});

  final ApiClient client;
  final UserRepository userRepository;

  static const basePath = 'group_invitations';

  Future<GroupInvitation> getInvitation() async {
    var user = await userRepository.getUser();
    var invitationResponse = await client.get(path: '$basePath/${user.profile.email}');

    return GroupInvitationResponse.fromJson(invitationResponse).toModel();
  }

  Future<void> createInvitation({required GroupInvitation groupInvitation}) async {
    await client.put(
      path: '$basePath/${groupInvitation.toUserEmail}',
      data: GroupInvitationResponse.fromModel(groupInvitation).toJson(),
    );
  }
}
