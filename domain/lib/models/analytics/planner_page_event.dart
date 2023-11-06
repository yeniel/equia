import 'package:domain/domain.dart';

class PlannerPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.plannerPage;

  @override
  Map<String, dynamic> get properties => {};
}