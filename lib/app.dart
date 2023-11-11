import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/authentication/authentication.dart';
import 'presentation/home/home.dart';
import 'presentation/login/login.dart';
import 'presentation/splash/splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(
        authService: context.read<AuthService>(),
        userRepository: context.read<UserRepository>(),
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
      // theme: ThemeData(
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.light,
      //     primary: Colores.acelga,
      //     onPrimary: Colors.white,
      //     secondary: Colores.acelga,
      //     onSecondary: Colors.white,
      //     error: Colores.rabano,
      //     onError: Colors.white,
      //     background: Colors,
      //     onBackground: onBackground,
      //     surface: surface,
      //     onSurface: onSurface,
      //   ),
      // ),
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
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
                break;
              default:
                break;
            }
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
