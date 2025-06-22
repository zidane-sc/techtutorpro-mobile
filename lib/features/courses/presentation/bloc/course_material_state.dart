part of 'course_material_bloc.dart';

class CourseMaterialState extends Equatable {
  final CourseEntity? course;
  final List<CourseMaterialEntity> allMaterials;
  final int currentMaterialIndex;
  final CourseMaterialEntity? currentMaterial;
  final Map<String, bool> sectionStates;
  final bool isLoading;
  final bool isLastMaterial;
  final String? error;

  const CourseMaterialState({
    this.course,
    this.allMaterials = const [],
    this.currentMaterialIndex = 0,
    this.currentMaterial,
    this.sectionStates = const {},
    this.isLoading = true,
    this.isLastMaterial = false,
    this.error,
  });

  CourseMaterialState copyWith({
    CourseEntity? course,
    List<CourseMaterialEntity>? allMaterials,
    int? currentMaterialIndex,
    CourseMaterialEntity? currentMaterial,
    Map<String, bool>? sectionStates,
    bool? isLoading,
    bool? isLastMaterial,
    String? error,
  }) {
    return CourseMaterialState(
      course: course ?? this.course,
      allMaterials: allMaterials ?? this.allMaterials,
      currentMaterialIndex: currentMaterialIndex ?? this.currentMaterialIndex,
      currentMaterial: currentMaterial ?? this.currentMaterial,
      sectionStates: sectionStates ?? this.sectionStates,
      isLoading: isLoading ?? this.isLoading,
      isLastMaterial: isLastMaterial ?? this.isLastMaterial,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        course,
        allMaterials,
        currentMaterialIndex,
        currentMaterial,
        sectionStates,
        isLoading,
        isLastMaterial,
        error,
      ];
}
