part of 'home_bloc.dart';

enum HomeTab { agenda, planner, timeBank, account }

abstract class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.agenda,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeTabSetState extends HomeState {
  const HomeTabSetState({required tab}) : super(tab: tab);
}
