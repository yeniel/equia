part of 'agenda_bloc.dart';

abstract class AgendaEvent extends Equatable {
  const AgendaEvent();
}

class AgendaInitEvent extends AgendaEvent {
  const AgendaInitEvent();

  @override
  List<Object?> get props => [];
}
