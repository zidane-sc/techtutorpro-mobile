part of 'purchased_course_bloc.dart';

abstract class PurchasedCourseEvent extends Equatable {
  const PurchasedCourseEvent();

  @override
  List<Object> get props => [];
}

class FetchPurchasedCourses extends PurchasedCourseEvent {}

class UpdateCourseProgress extends PurchasedCourseEvent {
  final String courseId;
  final int completedMaterials;

  const UpdateCourseProgress({
    required this.courseId,
    required this.completedMaterials,
  });

  @override
  List<Object> get props => [courseId, completedMaterials];
}
