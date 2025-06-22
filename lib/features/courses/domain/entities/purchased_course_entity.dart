import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_status.dart';

class PurchasedCourseEntity extends Equatable {
  final String id; // This can be the course ID
  final String title;
  final String thumbnail;
  final double progress;
  final DateTime lastAccessed;
  final CourseStatus status;

  const PurchasedCourseEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.progress,
    required this.lastAccessed,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [id, title, thumbnail, progress, lastAccessed, status];
}
