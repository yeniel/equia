import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../onboarding_group_info.dart';

class OnboardingGroupInfoPage extends StatelessWidget {
  const OnboardingGroupInfoPage({super.key, required this.onContinue});

  final VoidCallback onContinue;

  static Route route({required VoidCallback onContinue}) {
    return MaterialPageRoute(builder: (_) => OnboardingGroupInfoPage(onContinue: onContinue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingGroupInfoBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        groupsRepository: RepositoryProvider.of<GroupsRepository>(context),
        groupInvitationsRepository: RepositoryProvider.of<GroupInvitationsRepository>(context),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const OnboardingGroupInfoInitEvent()),
      child: OnboardingGroupView(onContinue: onContinue),
    );
  }
}

class OnboardingGroupView extends StatelessWidget {
  const OnboardingGroupView({Key? key, required this.onContinue}) : super(key: key);

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<OnboardingGroupInfoBloc, OnboardingGroupInfoState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.waving_hand, size: 150),
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
                  FilledButton(
                    onPressed: onContinue,
                    child: Text(S.continue_button),
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
