import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const OnboardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnboardingBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          groupsRepository: RepositoryProvider.of<GroupsRepository>(context),
          groupInvitationsRepository: RepositoryProvider.of<GroupInvitationsRepository>(context),
          analyticsManager: context.read<AnalyticsManager>(),
        );
      },
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: controller,
          children: const <Widget>[
            Center(
              child: OnboardingGroupPage(),
            ),
            Center(
              child: Text('Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}
