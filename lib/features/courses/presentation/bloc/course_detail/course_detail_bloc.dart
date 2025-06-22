import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_review_entity.dart';
import 'package:techtutorpro/features/courses/domain/usecases/get_course_detail_usecase.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

@injectable
class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseDetailUseCase getCourseDetailUseCase;

  CourseDetailBloc(this.getCourseDetailUseCase) : super(CourseDetailInitial()) {
    on<FetchCourseDetail>(_onFetchCourseDetail);
  }

  Future<void> _onFetchCourseDetail(
      FetchCourseDetail event, Emitter<CourseDetailState> emit) async {
    emit(CourseDetailLoading());
    final result = await getCourseDetailUseCase(event.courseId);
    result.fold(
      (failure) => emit(CourseDetailError(failure)),
      (course) => emit(CourseDetailLoaded(course)),
    );
  }

  CourseEntity _getMockCourseDetails(String courseId) {
    return CourseEntity(
      id: courseId,
      title: 'Belajar Python: Dari Dasar hingga Mahir',
      thumbnail: '', // Will be handled in UI
      description:
          'Python adalah bahasa pemrograman interpretatif multiguna. Tidak seperti bahasa lain yang lebih sulit untuk dibaca dan dipahami, python lebih menekankan pada keterbacaan kode agar lebih mudah untuk memahami sintaks. Hal ini membuat Python sangat mudah dipelajari baik untuk pemula maupun untuk yang sudah menguasai bahasa pemrograman lain.',
      price: 150000,
      discountedPrice: 75000,
      level: 'Menengah',
      studentCount: 876,
      materialCount: 40,
      durationInMinutes: 480,
      rating: 4.8,
      reviewCount: 250,
      tags: ['python', 'backend', 'data-science'],
      method: 'Video',
      materialSections: [
        CourseMaterialSectionEntity(
          id: 'section1',
          title: 'Kenalan dengan Python',
          materials: [
            const CourseMaterialEntity(
                id: 'mat1',
                title: 'Apa itu Python',
                type: CourseMaterialType.text,
                durationInMinutes: 10),
            const CourseMaterialEntity(
                id: 'mat2',
                title: 'Instalasi Python',
                type: CourseMaterialType.video,
                durationInMinutes: 15),
          ],
        ),
        CourseMaterialSectionEntity(
          id: 'section2',
          title: 'Dasar Python',
          materials: [
            const CourseMaterialEntity(
                id: 'mat3',
                title: 'Variables & Tipe Data',
                type: CourseMaterialType.video,
                durationInMinutes: 20),
            const CourseMaterialEntity(
                id: 'mat4',
                title: 'Input & Output',
                type: CourseMaterialType.text,
                durationInMinutes: 10),
          ],
        ),
        const CourseMaterialSectionEntity(
          id: 'section3',
          title: 'Operator',
          materials: [],
        ),
        const CourseMaterialSectionEntity(
          id: 'section4',
          title: 'Kontrol Flow',
          materials: [],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'review1',
          studentName: 'Student',
          review: 'kerennn cuy',
          rating: 5,
          date: DateTime(2024, 6, 13),
        ),
        CourseReviewEntity(
          id: 'review2',
          studentName: 'Muhammad Zidane Sc',
          review: 'Anjay mantap sesuai pesanan, menyala 🔥🔥',
          rating: 5,
          date: DateTime(2024, 6, 13),
        ),
      ],
    );
  }
}
