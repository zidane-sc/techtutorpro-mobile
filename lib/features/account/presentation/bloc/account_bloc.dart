import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/account/domain/entities/user_entity.dart';
import 'package:techtutorpro/features/account/domain/usecases/get_user_profile.dart';
import 'package:techtutorpro/features/account/domain/usecases/update_user_profile.dart';

part 'account_event.dart';
part 'account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserProfile _getUserProfile;
  final UpdateUserProfile _updateUserProfile;

  AccountBloc({
    required GetUserProfile getUserProfile,
    required UpdateUserProfile updateUserProfile,
  })  : _getUserProfile = getUserProfile,
        _updateUserProfile = updateUserProfile,
        super(AccountInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onFetchUserProfile(
    FetchUserProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());

    final result = await _getUserProfile();

    result.fold(
      (failure) => emit(AccountError(message: failure)),
      (user) => emit(AccountLoaded(user: user)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());

    final result = await _updateUserProfile(event.user);

    result.fold(
      (failure) => emit(AccountError(message: failure)),
      (user) => emit(AccountLoaded(user: user)),
    );
  }
}
