import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../onboarding_summary.dart';

class OnboardingSummaryPage extends StatelessWidget {
  const OnboardingSummaryPage({super.key, required this.onContinue});

  final VoidCallback onContinue;

  static Route route({required VoidCallback onContinue}) {
    return MaterialPageRoute(builder: (_) => OnboardingSummaryPage(onContinue: onContinue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingSummaryBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const OnboardingSummaryInitEvent()),
      child: OnboardingSummaryView(onContinue: onContinue),
    );
  }
}

class OnboardingSummaryView extends StatelessWidget {
  const OnboardingSummaryView({Key? key, required this.onContinue}) : super(key: key);

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<OnboardingSummaryBloc, OnboardingSummaryState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.summarize, size: 150),
                  Text(
                    S.onboarding_summary_title(state.user.profile.displayName),
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    S.onboarding_summary_message,
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
