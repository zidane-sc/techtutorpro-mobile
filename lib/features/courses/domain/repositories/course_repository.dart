import 'package:dartz/dartz.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';

abstract class CourseRepository {
  Future<Either<String, List<CourseEntity>>> getCourses();
  Future<Either<String, CourseEntity>> getCourseDetail(String courseId);
}
