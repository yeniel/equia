import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/group/create/create_group.dart';
import 'package:equia/presentation/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          children: <Widget>[
            OnboardingGroupInfoPage(onContinue: _onContinue),
            CreateGroupPage(onCreateGroup: _onCreateGroup),
          ],
        ),
      ),
    );
  }

  void _onContinue() {
    controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void _onCreateGroup() {}
}
