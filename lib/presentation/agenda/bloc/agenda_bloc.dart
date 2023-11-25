import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _analyticsManager = analyticsManager,
        super(const AgendaState()) {
    on<AgendaInitEvent>(_onAgendaInitEvent);
  }

  final AnalyticsManager _analyticsManager;

  Future<void> _onAgendaInitEvent(AgendaInitEvent event, Emitter<AgendaState> emit) async {
    emit(state);
    _analyticsManager.logEvent(AgendaPageEvent());
  }
}
