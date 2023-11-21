import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required AuthService authService,
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _authService = authService,
        _userRepository = userRepository,
        _analyticsManager = analyticsManager,
        super(const AccountState()) {
    on<AccountInitEvent>(_onAccountInitEvent);
    on<AccountLogoutEvent>(_onAccountLogoutEvent);
  }

  final AuthService _authService;
  final UserRepository _userRepository;
  final AnalyticsManager _analyticsManager;

  Future<void> _onAccountInitEvent(AccountInitEvent event, Emitter<AccountState> emit) async {
    _analyticsManager.logEvent(AccountPageEvent());

    await emit.forEach<UserModel?>(
      _userRepository.getUserStream(),
      onData: (user) {
        if (user == null) {
          return state.copyWith(user: null);
        }

        return state.copyWith(user: user);
      },
      onError: (_, __) => state,
    );
  }

  void _onAccountLogoutEvent(AccountLogoutEvent event, Emitter<AccountState> emit) {
    _authService.logout();
    _analyticsManager.logEvent(LogoutEvent());
  }
}
