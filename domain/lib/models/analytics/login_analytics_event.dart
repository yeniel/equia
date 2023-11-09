import 'package:domain/domain.dart';

class LoginAnalyticsEvent implements AnalyticsEvent {
  LoginAnalyticsEvent({this.userProfile});

  @override
  String get name => AnalyticsEventName.login;

  late final UserProfile? userProfile;

  @override
  Map<String, dynamic> get properties => {'uid': userProfile?.uid ?? ""};
}