import 'package:dartz/dartz.dart';
import 'package:techtutorpro/features/account/domain/entities/user_entity.dart';

abstract class AccountRepository {
  Future<Either<String, UserEntity>> getUserProfile();
  Future<Either<String, UserEntity>> updateUserProfile(UserEntity user);
}
