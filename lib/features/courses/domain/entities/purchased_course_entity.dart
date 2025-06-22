import 'package:equatable/equatable.dart';

class PurchasedCourseEntity extends Equatable {
  final String id; // This can be the course ID
  final String title;
  final String thumbnail;
  final double progress;
  final DateTime lastAccessed;

  const PurchasedCourseEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.progress,
    required this.lastAccessed,
  });

  @override
  List<Object?> get props => [id, title, thumbnail, progress, lastAccessed];
}
