import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/usecases/get_courses_usecase.dart';
import 'package:techtutorpro/injection.dart';

part 'course_event.dart';
part 'course_state.dart';

@injectable
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesUseCase getCoursesUseCase;
  late List<CourseEntity>
      _masterCourses; // To hold the original list of courses
  CourseBloc(this.getCoursesUseCase) : super(CourseInitial()) {
    on<FetchCourses>(_onFetchCourses);
    on<ApplyFilters>(_onApplyFilters);
    on<UpdateFilterState>(_onUpdateFilterState);
  }

  // Filter state properties
  List<String> _selectedTeknologi = [];
  List<String> _selectedLevels = [];
  List<String> _selectedMetode = [];

  // Getters for current filter state
  List<String> get selectedTeknologi => _selectedTeknologi;
  List<String> get selectedLevels => _selectedLevels;
  List<String> get selectedMetode => _selectedMetode;

  Future<void> _onFetchCourses(
      FetchCourses event, Emitter<CourseState> emit) async {
    emit(CourseLoading());
    final result = await getCoursesUseCase();
    result.fold(
      (failure) => emit(CourseError(message: failure)),
      (courses) {
        _masterCourses = courses;
        emit(CourseLoaded(courses: courses));
      },
    );
  }

  void _onApplyFilters(ApplyFilters event, Emitter<CourseState> emit) {
    emit(CourseLoading());

    final filteredCourses = _masterCourses.where((course) {
      final levelMatch = event.selectedLevels.isEmpty ||
          event.selectedLevels.contains(course.level);

      final teknologyMatch = event.selectedTeknologi.isEmpty ||
          course.tags.any((tag) => event.selectedTeknologi.contains(tag));

      final methodMatch = event.selectedMetode.isEmpty ||
          event.selectedMetode.contains(course.method);

      return levelMatch && teknologyMatch && methodMatch;
    }).toList();

    emit(CourseLoaded(courses: filteredCourses));
  }

  void _onUpdateFilterState(
      UpdateFilterState event, Emitter<CourseState> emit) {
    _selectedTeknologi = List.from(event.selectedTeknologi);
    _selectedLevels = List.from(event.selectedLevels);
    _selectedMetode = List.from(event.selectedMetode);

    // Emit current state to notify listeners of filter state change
    if (state is CourseLoaded) {
      emit(CourseLoaded(courses: (state as CourseLoaded).courses));
    }
  }
}
