part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends AccountEvent {}

class UpdateProfile extends AccountEvent {
  final UserEntity user;

  const UpdateProfile({required this.user});

  @override
  List<Object> get props => [user];
}
