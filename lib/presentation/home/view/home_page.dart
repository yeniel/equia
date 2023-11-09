import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/config/view/config_page.dart';
import 'package:equia/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  int currentPageIndex = 0;
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyAgendaTab = GlobalKey();
  GlobalKey keyPlannerTab = GlobalKey();
  GlobalKey keyTimeBankTab = GlobalKey();
  GlobalKey keyConfigTab = GlobalKey();

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
    var S = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            key: keyAgendaTab,
            selectedIcon: const Icon(Icons.view_agenda),
            icon: const Icon(Icons.view_agenda_outlined),
            label: S.agenda,
          ),
          NavigationDestination(
            key: keyPlannerTab,
            selectedIcon: const Icon(Icons.compare),
            icon: const Icon(Icons.compare_outlined),
            label: S.planner,
          ),
          NavigationDestination(
            key: keyTimeBankTab,
            selectedIcon: const Icon(Icons.more_time),
            icon: const Icon(Icons.more_time_outlined),
            label: S.time_bank
          ),
          NavigationDestination(
            key: keyConfigTab,
            selectedIcon: const Icon(Icons.manage_accounts),
            icon: const Icon(Icons.manage_accounts_outlined),
            label: S.account
          ),
        ],
      ),
      body: <Widget>[
        Container(),
        Container(),
        Container(),
        const ConfigPage(),
      ][currentPageIndex],
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
        keyTarget: keyConfigTab,
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
