import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/account/domain/entities/user_entity.dart';
import 'package:techtutorpro/features/account/domain/repositories/account_repository.dart';

@injectable
class GetUserProfile {
  final AccountRepository repository;

  GetUserProfile(this.repository);

  Future<Either<String, UserEntity>> call() {
    return repository.getUserProfile();
  }
}
