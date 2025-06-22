import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/repositories/course_repository.dart';

@injectable
class GetCourseDetailUseCase {
  final CourseRepository repository;

  GetCourseDetailUseCase(this.repository);

  Future<Either<String, CourseEntity>> call(String courseId) {
    return repository.getCourseDetail(courseId);
  }
}
