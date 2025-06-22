import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/account/domain/entities/user_entity.dart';
import 'package:techtutorpro/features/account/domain/repositories/account_repository.dart';

@injectable
class UpdateUserProfile {
  final AccountRepository repository;

  UpdateUserProfile(this.repository);

  Future<Either<String, UserEntity>> call(UserEntity user) {
    return repository.updateUserProfile(user);
  }
}
