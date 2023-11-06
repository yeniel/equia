import 'package:domain/domain.dart';

class TimeBankPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.timeBankPage;

  @override
  Map<String, dynamic> get properties => {};
}