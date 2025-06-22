part of 'course_material_bloc.dart';

abstract class CourseMaterialEvent extends Equatable {
  const CourseMaterialEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourseMaterial extends CourseMaterialEvent {
  final CourseEntity course;

  const LoadCourseMaterial(this.course);

  @override
  List<Object?> get props => [course];
}

class SelectMaterial extends CourseMaterialEvent {
  final String materialId;

  const SelectMaterial(this.materialId);

  @override
  List<Object?> get props => [materialId];
}

class NextMaterial extends CourseMaterialEvent {
  const NextMaterial();
}

class ToggleSection extends CourseMaterialEvent {
  final String sectionId;

  const ToggleSection(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}
