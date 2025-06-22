part of 'course_detail_bloc.dart';

abstract class CourseDetailState extends Equatable {
  const CourseDetailState();

  @override
  List<Object> get props => [];
}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final CourseEntity course;

  const CourseDetailLoaded(this.course);

  @override
  List<Object> get props => [course];
}

class CourseDetailError extends CourseDetailState {
  final String message;

  const CourseDetailError(this.message);

  @override
  List<Object> get props => [message];
}
