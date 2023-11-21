import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../join_group.dart';

class JoinGroupPage extends StatelessWidget {
  const JoinGroupPage({super.key, required this.onJoinGroup});

  final VoidCallback onJoinGroup;

  static Route route({required VoidCallback onJoinGroup}) {
    return MaterialPageRoute(builder: (_) => JoinGroupPage(onJoinGroup: onJoinGroup));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JoinGroupBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        groupsRepository: RepositoryProvider.of<GroupsRepository>(context),
        groupInvitationsRepository: RepositoryProvider.of<GroupInvitationsRepository>(context),
      )..add(const JoinGroupInitEvent()),
      child: GroupCreateView(onJoinGroup: onJoinGroup),
    );
  }
}

class GroupCreateView extends StatelessWidget {
  const GroupCreateView({Key? key, required this.onJoinGroup}) : super(key: key);

  final VoidCallback onJoinGroup;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<JoinGroupBloc, JoinGroupState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.group, size: 150),
                  Text(
                    S.group_invitation,
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.group_add),
                      title: Text(state.groupName),
                      subtitle: Text(state.groupInvitation.fromUserName),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      var createEvent = const JoinGroupJoinEvent();

                      context.read<JoinGroupBloc>().add(createEvent);
                      onJoinGroup();
                    },
                    child: Text(S.join),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
