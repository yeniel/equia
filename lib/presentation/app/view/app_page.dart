import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/group/join/join_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../home/home.dart';
import '../../login/login.dart';
import '../../onboarding/onboarding.dart';
import '../../splash/splash.dart';
import '../app.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(
        authService: context.read<AuthService>(),
        userRepository: context.read<UserRepository>(),
        groupInvitationsRepository: context.read<GroupInvitationsRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      ),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  AppViewState createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    listenLocalNotifications();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
      navigatorKey: _navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            Route route;

            switch (state.authStatus) {
              case AppAuthStatus.authenticated:
                switch (state.initialRoute) {
                  case InitialRoute.home:
                    route = HomePage.route();
                    break;
                  case InitialRoute.onboarding:
                    route = OnboardingPage.route();
                    break;
                  case InitialRoute.invitation:
                    route = JoinGroupPage.route(onJoinGroup: () {
                      _navigator.pushAndRemoveUntil<void>(HomePage.route(), (route) => false);
                    });
                    break;
                }
                break;
              case AppAuthStatus.unauthenticated:
              case AppAuthStatus.unknown:
                route = LoginPage.route();
                break;
            }

            _navigator.pushAndRemoveUntil<void>(route, (route) => false);
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }

  void listenLocalNotifications() {
    // AwesomeNotifications().actionStream.listen((ReceivedNotification receivedNotification) {
    // Navigator.of(context).pushNamed(
    //     '/NotificationPage',
    //     arguments: {
    //       // your page params. I recommend you to pass the
    //       // entire *receivedNotification* object
    //       id: receivedNotification.id
    //     }
    // );
    // });
  }
}
