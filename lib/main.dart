import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/app.dart';
import 'package:equia/firebase_options.dart';
import 'package:equia/presentation/analytics/amplitude_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Prefs.init();

      await AwesomeNotifications().initialize(
          null,
          [
            NotificationChannel(
                channelGroupKey: 'basic_channel_group',
                channelKey: 'basic_channel',
                channelName: 'Basic notifications',
                channelDescription: 'Notification channel for basic tests',
                defaultColor: Colors.green,
                ledColor: Colors.white)
          ],
          channelGroups: [
            NotificationChannelGroup(
              channelGroupName: 'Basic group',
              channelGroupKey: 'basic_channel_group',
            )
          ],
          debug: true
      );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      var authService = AuthService();
      var analyticsManager = AmplitudeManager();

      await analyticsManager.init();

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authService),
            // RepositoryProvider(create: (context) => repository),
            // ignore: unnecessary_cast
            RepositoryProvider(create: (context) => analyticsManager as AnalyticsManager),
          ],
          child: const App(),
        ),
      );
    },
        (error, st) {},
  );
}
