import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/group/add_member/add_member.dart';
import 'package:equia/presentation/group/create/create_group.dart';
import 'package:equia/presentation/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/view/home_page.dart';

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
        )..add(const OnboardingInitEvent());
      },
      child: OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  final PageController controller = PageController();

  OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            OnboardingWelcomePage(onContinue: _nextPage),
            CreateGroupPage(onCreateGroup: _nextPage),
            AddMemberPage(onAddMember: _nextPage),
            OnboardingSummaryPage(onContinue: () => _endOnboarding(context)),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void _endOnboarding(BuildContext context) {
    Navigator.pushAndRemoveUntil<void>(context, HomePage.route(), (route) => false);
  }
}
