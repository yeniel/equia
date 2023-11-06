import 'package:domain/domain.dart';

class LoginTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.agendaPage;

  @override
  Map<String, dynamic> get properties => {};
}