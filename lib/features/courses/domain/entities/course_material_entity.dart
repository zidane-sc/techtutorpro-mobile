import 'package:equatable/equatable.dart';

enum CourseMaterialType { video, text }

class CourseMaterialEntity extends Equatable {
  final String id;
  final String title;
  final CourseMaterialType type;
  final int durationInMinutes;
  final bool isCompleted;
  final String? content; // For text materials
  final String? videoUrl; // For video materials

  const CourseMaterialEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.durationInMinutes,
    this.isCompleted = false,
    this.content,
    this.videoUrl,
  });

  @override
  List<Object?> get props =>
      [id, title, type, durationInMinutes, isCompleted, content, videoUrl];
}

class CourseMaterialSectionEntity extends Equatable {
  final String id;
  final String title;
  final List<CourseMaterialEntity> materials;

  const CourseMaterialSectionEntity({
    required this.id,
    required this.title,
    required this.materials,
  });

  @override
  List<Object?> get props => [id, title, materials];
}
