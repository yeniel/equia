import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthService authService,
    required AnalyticsManager analyticsManager,
  })  : _authService = authService,
        _analyticsManager = analyticsManager,
        super(HomeInitial()) {
    on<HomeSetTabEvent>(_onHomeSetTab);

    var user = _authService.currentUser;

    if (user != null) {
      _analyticsManager.setUserId(user.id.toString());
    }
  }

  final AuthService _authService;
  final AnalyticsManager _analyticsManager;

  Future<void> _onHomeSetTab(HomeSetTabEvent event, Emitter<HomeState> emit) async {
    emit(HomeTabSetState(tab: event.tab));

    switch (event.tab) {
      case HomeTab.agenda:
        _analyticsManager.logEvent(AgendaPageEvent());
        break;
      case HomeTab.planner:
        _analyticsManager.logEvent(PlannerPageEvent());
        break;
      case HomeTab.timeBank:
        _analyticsManager.logEvent(TimeBankPageEvent());
        break;
      case HomeTab.account:
        _analyticsManager.logEvent(AccountPageEvent());
        break;
    }
  }
}
