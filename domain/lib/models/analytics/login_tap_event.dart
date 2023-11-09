import 'package:domain/domain.dart';

class LoginTapEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.loginTap;

  @override
  Map<String, dynamic> get properties => {};
}