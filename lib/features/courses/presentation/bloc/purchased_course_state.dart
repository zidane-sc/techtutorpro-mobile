import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';

abstract class PurchasedCourseState extends Equatable {
  final List<PurchasedCourseEntity> courses;

  const PurchasedCourseState({this.courses = const []});

  @override
  List<Object?> get props => [courses];
}

class PurchasedCourseInitial extends PurchasedCourseState {}

class PurchasedCourseLoading extends PurchasedCourseState {
  const PurchasedCourseLoading({required super.courses});
}

class PurchasedCourseLoaded extends PurchasedCourseState {
  const PurchasedCourseLoaded({required super.courses});
}

class PurchasedCourseError extends PurchasedCourseState {
  final String message;

  const PurchasedCourseError({required this.message, required super.courses});

  @override
  List<Object?> get props => [message, courses];
}

class NavigateToCourseMaterial extends PurchasedCourseState {
  final CourseEntity course;

  const NavigateToCourseMaterial(
      {required this.course, required List<PurchasedCourseEntity> allCourses})
      : super(courses: allCourses);

  @override
  List<Object?> get props => [course, courses];
}
