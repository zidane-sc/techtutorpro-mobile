import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profilePhoto;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [id, name, username, email, profilePhoto];

  UserEntity copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? profilePhoto,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
