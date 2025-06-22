import 'package:equatable/equatable.dart';

class CourseReviewEntity extends Equatable {
  final String id;
  final String studentName;
  final String? studentImageUrl;
  final String review;
  final double rating;
  final DateTime date;

  const CourseReviewEntity({
    required this.id,
    required this.studentName,
    this.studentImageUrl,
    required this.review,
    required this.rating,
    required this.date,
  });

  @override
  List<Object?> get props =>
      [id, studentName, studentImageUrl, review, rating, date];
}
