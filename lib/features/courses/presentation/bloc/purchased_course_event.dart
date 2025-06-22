import 'package:equatable/equatable.dart';

abstract class PurchasedCourseEvent extends Equatable {
  const PurchasedCourseEvent();

  @override
  List<Object> get props => [];
}

class FetchPurchasedCourses extends PurchasedCourseEvent {
  const FetchPurchasedCourses();
}

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

class GetCourseForNavigation extends PurchasedCourseEvent {
  final String courseId;

  const GetCourseForNavigation(this.courseId);

  @override
  List<Object> get props => [courseId];
}
