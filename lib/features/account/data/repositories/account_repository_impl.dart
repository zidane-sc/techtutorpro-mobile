import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/account/data/datasources/account_remote_datasource.dart';
import 'package:techtutorpro/features/account/data/models/user_model.dart';
import 'package:techtutorpro/features/account/domain/entities/user_entity.dart';
import 'package:techtutorpro/features/account/domain/repositories/account_repository.dart';

@Injectable(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> getUserProfile() async {
    try {
      final userModel = await remoteDataSource.getUserProfile();
      return Right(userModel);
    } catch (e) {
      return Left('Failed to get user profile: $e');
    }
  }

  @override
  Future<Either<String, UserEntity>> updateUserProfile(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final updatedUser = await remoteDataSource.updateUserProfile(userModel);
      return Right(updatedUser);
    } catch (e) {
      return Left('Failed to update user profile: $e');
    }
  }
}
