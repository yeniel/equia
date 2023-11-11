part of 'home_bloc.dart';

enum HomeTab { agenda, planner, timeBank, account }

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}