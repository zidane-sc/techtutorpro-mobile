part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> courses;
  final bool isFiltered;
  final String selectedCategory;

  const CourseLoaded({
    required this.courses,
    this.isFiltered = false,
    this.selectedCategory = 'all',
  });

  @override
  List<Object> get props => [courses, isFiltered, selectedCategory];
}

class CourseError extends CourseState {
  final String message;

  const CourseError({required this.message});

  @override
  List<Object> get props => [message];
}
