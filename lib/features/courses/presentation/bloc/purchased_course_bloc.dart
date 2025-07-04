import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/domain/usecases/get_course_detail_usecase.dart';
import 'package:techtutorpro/features/courses/domain/usecases/get_purchased_courses_usecase.dart';
import 'package:techtutorpro/features/courses/domain/usecases/update_course_progress_usecase.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_event.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_state.dart';

@injectable
class PurchasedCourseBloc
    extends Bloc<PurchasedCourseEvent, PurchasedCourseState> {
  final GetPurchasedCoursesUseCase _getPurchasedCoursesUseCase;
  final UpdateCourseProgressUseCase _updateCourseProgressUseCase;
  final GetCourseDetailUseCase _getCourseDetailUseCase;

  PurchasedCourseBloc(
    this._getPurchasedCoursesUseCase,
    this._updateCourseProgressUseCase,
    this._getCourseDetailUseCase,
  ) : super(PurchasedCourseInitial()) {
    on<FetchPurchasedCourses>(_onFetchPurchasedCourses);
    on<UpdateCourseProgress>(_onUpdateCourseProgress);
    on<GetCourseForNavigation>(_onGetCourseForNavigation);
  }

  Future<void> _onGetCourseForNavigation(
    GetCourseForNavigation event,
    Emitter<PurchasedCourseState> emit,
  ) async {
    final result = await _getCourseDetailUseCase(event.courseId);
    result.fold(
      (failure) =>
          emit(PurchasedCourseError(message: failure, courses: state.courses)),
      (course) => emit(
          NavigateToCourseMaterial(course: course, allCourses: state.courses)),
    );
  }

  Future<void> _onFetchPurchasedCourses(
    FetchPurchasedCourses event,
    Emitter<PurchasedCourseState> emit,
  ) async {
    emit(PurchasedCourseLoading(courses: state.courses));

    final result = await _getPurchasedCoursesUseCase();

    result.fold(
      (failure) =>
          emit(PurchasedCourseError(message: failure, courses: state.courses)),
      (courses) => emit(PurchasedCourseLoaded(courses: courses)),
    );
  }

  Future<void> _onUpdateCourseProgress(
    UpdateCourseProgress event,
    Emitter<PurchasedCourseState> emit,
  ) async {
    if (state is PurchasedCourseLoaded) {
      final currentState = state as PurchasedCourseLoaded;
      emit(PurchasedCourseLoading(courses: currentState.courses));

      final result = await _updateCourseProgressUseCase(
        event.courseId,
        event.completedMaterials,
      );

      result.fold(
        (failure) => emit(PurchasedCourseError(
            message: failure, courses: currentState.courses)),
        (updatedCourse) {
          // Update the course in the list
          final updatedCourses = currentState.courses.map((course) {
            if (course.id == event.courseId) {
              return updatedCourse;
            }
            return course;
          }).toList();

          emit(PurchasedCourseLoaded(courses: updatedCourses));
        },
      );
    }
  }
}
