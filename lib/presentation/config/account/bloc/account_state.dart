part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.user = UserModel.empty});

  final UserModel? user;

  AccountState copyWith({UserModel? user}) {
    return AccountState(user: user);
  }

  @override
  List<Object> get props => [user ?? ""];
}
