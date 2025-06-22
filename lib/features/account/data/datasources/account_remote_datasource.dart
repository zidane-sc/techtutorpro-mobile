import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/account/data/models/user_model.dart';

abstract class AccountRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(UserModel user);
}

@Injectable(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  @override
  Future<UserModel> getUserProfile() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock user data
    return const UserModel(
      id: '1',
      name: 'John Doe',
      username: 'johndoe',
      email: 'john.doe@example.com',
      profilePhoto: null,
    );
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this would send the data to the server
    // For now, we'll just return the updated user
    return user;
  }
}
