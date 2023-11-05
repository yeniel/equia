import 'package:amplitude_flutter/amplitude.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/others/api_keys.dart';

class AmplitudeManager implements AnalyticsManager {
  final analytics = Amplitude.getInstance(instanceName: 'Equia');

  @override
  Future<void> init() async {
    await analytics.init(ApiKeys.amplitudeApiKey);
    await analytics.enableCoppaControl();
    await analytics.trackingSessionEvents(true);

    logEvent(StartAppAnalyticsEvent());
  }

  @override
  Future<void> setUserId(String? userId) async {
    await analytics.setUserId(userId);
  }

  @override
  void logEvent(AnalyticsEvent event) {
    analytics.logEvent(event.name, eventProperties: event.properties);
  }
}