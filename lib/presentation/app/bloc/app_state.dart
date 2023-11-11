part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.authStatus = AppAuthStatus.unknown,
    this.initialRoute = InitialRoute.home,
  });

  const AppState.unknown() : this();
  const AppState.unauthenticated() : this(authStatus: AppAuthStatus.unauthenticated);
  const AppState.authenticated() : this(authStatus: AppAuthStatus.authenticated);
  const AppState.authenticatedNewUser() : this(authStatus: AppAuthStatus.authenticated, initialRoute: InitialRoute.onboarding);

  final AppAuthStatus authStatus;
  final InitialRoute initialRoute;

  AppState copyWith({authStatus, initialRoute}) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      initialRoute: initialRoute ?? this.initialRoute,
    );
  }

  @override
  List<Object> get props => [authStatus, initialRoute];
}
