part of 'add_member_bloc.dart';

abstract class AddMemberEvent extends Equatable {
  const AddMemberEvent();
}

class AddMemberInitEvent extends AddMemberEvent {
  const AddMemberInitEvent();

  @override
  List<Object?> get props => [];
}

class AddMemberAddEvent extends AddMemberEvent {
  const AddMemberAddEvent({required this.memberEmail});

  final String memberEmail;

  @override
  List<Object?> get props => [memberEmail];
}
