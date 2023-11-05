import 'package:domain/domain.dart';

class StartAppAnalyticsEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.startApp;

  @override
  Map<String, dynamic> get properties => {};
}