import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/config/view/config_page.dart';
import 'package:equia/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home.dart';

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

  static List<Destination> allDestinations = <Destination>[
    Destination(
      key: GlobalKey(),
      index: 0,
      icon: Icons.view_agenda,
      selectedIcon: Icons.view_agenda_outlined,
      route: () => MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text("Agenda"),),body: Container())),
    ),
    Destination(
      key: GlobalKey(),
      index: 1,
      icon: Icons.compare,
      selectedIcon: Icons.compare_outlined,
      route: () => MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text("Planificación"),),body: Container())),
    ),
    Destination(
      key: GlobalKey(),
      index: 2,
      icon: Icons.more_time,
      selectedIcon: Icons.more_time_outlined,
      route: () => MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text("Banco de Tiempo"),),body: Container())),
    ),
    Destination(
      key: GlobalKey(),
      index: 3,
      icon: Icons.manage_accounts,
      selectedIcon: Icons.manage_accounts_outlined,
      route: () => ConfigPage.route(),
    ),
  ];

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
    var destinationLabels = [
      S.agenda,
      S.planner,
      S.time_bank,
      S.account,
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {

          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: allDestinations.map((destination) {
          return NavigationDestination(
            selectedIcon: Icon(destination.selectedIcon),
            icon: Icon(destination.icon),
            label: destinationLabels[destination.index],
          );
        }).toList(),
      ),
      body: allDestinations.map((Destination destination) {
        return DestinationView(destination: destination);
      }).toList()[currentPageIndex],
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
    return <TargetFocus>[
      _createTarget(
        identify: 'keyAgendaTab',
        keyTarget: allDestinations[0].key,
        text: 'En la pestaña inicial Agenda, verás la lista de tus próximas tareas',
      ),
      _createTarget(
        identify: 'keyPlannerTab',
        keyTarget: allDestinations[1].key,
        text: 'Aquí podrás ver la planificación de tareas y reparto equitativo del tiempo',
      ),
      _createTarget(
        identify: 'keyTimeBankTab',
        keyTarget: allDestinations[2].key,
        text: 'Aquí podrás crear tareas puntuales que se incluirán en el banco de tiempo',
      ),
      _createTarget(
        identify: 'keyAccountTab',
        keyTarget: allDestinations[3].key,
        text: 'Aquí podrás ver toda la información de tu cuenta',
      ),
    ];
  }

  TargetFocus _createTarget({
    required String identify,
    required GlobalKey keyTarget,
    required String text,
  }) {
    return TargetFocus(
      identify: identify,
      //keyTarget: keyTarget,
      alignSkip: Alignment.bottomLeft,
      enableOverlayTab: true,
      enableTargetTab: true,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
