import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';

part 'course_material_event.dart';
part 'course_material_state.dart';

class CourseMaterialBloc
    extends Bloc<CourseMaterialEvent, CourseMaterialState> {
  CourseMaterialBloc() : super(const CourseMaterialState()) {
    on<LoadCourseMaterial>(_onLoadCourseMaterial);
    on<SelectMaterial>(_onSelectMaterial);
    on<NextMaterial>(_onNextMaterial);
    on<ToggleSection>(_onToggleSection);
  }

  void _onLoadCourseMaterial(
    LoadCourseMaterial event,
    Emitter<CourseMaterialState> emit,
  ) {
    final allMaterials = <CourseMaterialEntity>[];
    final sectionStates = <String, bool>{};

    // Flatten all materials and initialize section states
    for (final section in event.course.materialSections) {
      sectionStates[section.id] = false; // Initially collapsed
      allMaterials.addAll(section.materials);
    }

    emit(state.copyWith(
      course: event.course,
      allMaterials: allMaterials,
      currentMaterialIndex: 0,
      currentMaterial: allMaterials.isNotEmpty ? allMaterials.first : null,
      sectionStates: sectionStates,
      isLoading: false,
    ));
  }

  void _onSelectMaterial(
    SelectMaterial event,
    Emitter<CourseMaterialState> emit,
  ) {
    final materialIndex = state.allMaterials.indexWhere(
      (material) => material.id == event.materialId,
    );

    if (materialIndex != -1) {
      emit(state.copyWith(
        currentMaterialIndex: materialIndex,
        currentMaterial: state.allMaterials[materialIndex],
      ));
    }
  }

  void _onNextMaterial(
    NextMaterial event,
    Emitter<CourseMaterialState> emit,
  ) {
    final nextIndex = state.currentMaterialIndex + 1;

    if (nextIndex < state.allMaterials.length) {
      emit(state.copyWith(
        currentMaterialIndex: nextIndex,
        currentMaterial: state.allMaterials[nextIndex],
      ));
    } else {
      // Reached the last material
      emit(state.copyWith(isLastMaterial: true));
    }
  }

  void _onToggleSection(
    ToggleSection event,
    Emitter<CourseMaterialState> emit,
  ) {
    final currentState = state.sectionStates[event.sectionId] ?? false;
    final newSectionStates = Map<String, bool>.from(state.sectionStates);
    newSectionStates[event.sectionId] = !currentState;

    emit(state.copyWith(sectionStates: newSectionStates));
  }
}
