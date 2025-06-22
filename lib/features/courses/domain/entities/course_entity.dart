import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_review_entity.dart';

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnail;
  final String description;
  final double price;
  final double? discountedPrice;
  final String level;
  final int studentCount;
  final int materialCount;
  final int durationInMinutes;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String method;
  final List<CourseMaterialSectionEntity> materialSections;
  final List<CourseReviewEntity> reviews;

  const CourseEntity({
    required this.id,
    required this.title,
    this.thumbnail = '',
    this.description = 'No description available.',
    required this.price,
    this.discountedPrice,
    required this.level,
    required this.studentCount,
    required this.materialCount,
    required this.durationInMinutes,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    this.method = 'Video', // Default to video
    this.materialSections = const [],
    this.reviews = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnail,
        description,
        price,
        discountedPrice,
        level,
        studentCount,
        materialCount,
        durationInMinutes,
        rating,
        reviewCount,
        tags,
        method,
        materialSections,
        reviews,
      ];
}
