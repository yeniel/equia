import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        authService: context.read<AuthService>(),
        analyticsManager: context.read<AnalyticsManager>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyAgendaTab = GlobalKey();
  GlobalKey keyPlannerTab = GlobalKey();
  GlobalKey keyTimeBankTab = GlobalKey();
  GlobalKey keyAccountTab = GlobalKey();

  @override
  void initState() {
    var showCoachmarks = Prefs.getBool(Prefs.showCoachmarksKey);

    if (showCoachmarks ?? true) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
      Prefs.setBool(Prefs.showCoachmarksKey, false);
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeBloc bloc) => bloc.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        // TODO: children: const [AgendaPage(), PlannerPage(), TimeBankPage(), AccountPage()],
        children: const [],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              key: keyAgendaTab,
              groupValue: selectedTab,
              value: HomeTab.agenda,
              icon: const Icon(Icons.view_agenda_rounded),
            ),
            _HomeTabButton(
              key: keyPlannerTab,
              groupValue: selectedTab,
              value: HomeTab.planner,
              icon: const Icon(Icons.compare_rounded),
            ),
            _HomeTabButton(
              key: keyTimeBankTab,
              groupValue: selectedTab,
              value: HomeTab.timeBank,
              icon: const Icon(Icons.more_time_rounded),
            ),
            _HomeTabButton(
              key: keyAccountTab,
              groupValue: selectedTab,
              value: HomeTab.account,
              icon: const Icon(Icons.manage_accounts_rounded),
            ),
          ],
        ),
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.purple,
      paddingFocus: 10,
      opacityShadow: 0.8,
      hideSkip: true,
    );
  }

  List<TargetFocus> _createTargets() {
    var targets = <TargetFocus>[];

    targets.add(
      TargetFocus(
        identify: 'keyAgendaTab',
        keyTarget: keyAgendaTab,
        alignSkip: Alignment.bottomLeft,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'En la pestaña inicial Agenda, verás la lista de tus próximas tareas',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'keyPlannerTab',
        keyTarget: keyPlannerTab,
        alignSkip: Alignment.bottomLeft,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Aquí podrás ver la planificación de tareas y reparto equitativo del tiempo',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'keyTimeBankTab',
        keyTarget: keyTimeBankTab,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Aquí podrás crear tareas puntuales que se incluirán en el banco de tiempo',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'keyAccountTab',
        keyTarget: keyAccountTab,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Aquí podrás ver toda la información de tu cuenta',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeBloc>().add(HomeSetTabEvent(value)),
      iconSize: 32,
      color: groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
