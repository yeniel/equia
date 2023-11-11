import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../onboarding_group.dart';

class OnboardingGroupPage extends StatelessWidget {
  const OnboardingGroupPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const OnboardingGroupPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingGroupBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        groupsRepository: RepositoryProvider.of<GroupsRepository>(context),
        groupInvitationsRepository: RepositoryProvider.of<GroupInvitationsRepository>(context),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const OnboardingGroupInitEvent()),
      child: const OnboardingGroupView(),
    );
  }
}

class OnboardingGroupView extends StatelessWidget {
  const OnboardingGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<OnboardingGroupBloc, OnboardingGroupState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.onboarding_group_title(state.user.profile.displayName),
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    S.onboarding_group_message,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Icon(Icons.groups, size: 150),
                  FilledButton(
                    onPressed: () => context.read<OnboardingGroupBloc>().add(const OnboardingGroupCreateEvent()),
                    child: Text(S.onboarding_group_create),
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
