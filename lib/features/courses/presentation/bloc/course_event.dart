part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class FetchCourses extends CourseEvent {}

class ApplyFilters extends CourseEvent {
  final List<String> selectedLevels;
  final List<String> selectedTeknologi;
  final List<String> selectedMetode;

  const ApplyFilters({
    this.selectedLevels = const [],
    this.selectedTeknologi = const [],
    this.selectedMetode = const [],
  });

  @override
  List<Object> get props => [selectedLevels, selectedTeknologi, selectedMetode];
}

class UpdateFilterState extends CourseEvent {
  final List<String> selectedLevels;
  final List<String> selectedTeknologi;
  final List<String> selectedMetode;

  const UpdateFilterState({
    this.selectedLevels = const [],
    this.selectedTeknologi = const [],
    this.selectedMetode = const [],
  });

  @override
  List<Object> get props => [selectedLevels, selectedTeknologi, selectedMetode];
}

class SelectCategory extends CourseEvent {
  final String categoryId;

  const SelectCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
