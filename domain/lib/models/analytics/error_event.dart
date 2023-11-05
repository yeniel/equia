import 'package:domain/domain.dart';

class ErrorAnalyticsEvent implements AnalyticsEvent {
  ErrorAnalyticsEvent({required this.error});

  @override
  String get name => AnalyticsEventName.error;

  late final String error;

  @override
  Map<String, dynamic> get properties => {'error': error};
}