import 'package:domain/domain.dart';

class ConfigPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.configPage;

  @override
  Map<String, dynamic> get properties => {};
}