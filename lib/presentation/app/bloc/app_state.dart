part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.authStatus = AppAuthStatus.unknown,
    this.initialRoute = InitialRoute.home,
  });

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
