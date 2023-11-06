import 'package:domain/domain.dart';

class AgendaPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.agendaPage;

  @override
  Map<String, dynamic> get properties => {};
}