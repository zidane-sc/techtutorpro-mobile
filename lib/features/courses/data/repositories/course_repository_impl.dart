import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/data/datasources/course_remote_datasource.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/repositories/course_repository.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<CourseEntity>>> getCourses() async {
    try {
      final courses = await remoteDataSource.getCourses();
      return Right(courses);
    } catch (e) {
      return Left('Failed to fetch courses: $e');
    }
  }

  @override
  Future<Either<String, CourseEntity>> getCourseDetail(String courseId) async {
    try {
      final course = await remoteDataSource.getCourseDetail(courseId);
      return Right(course);
    } catch (e) {
      return Left('Failed to fetch course detail: $e');
    }
  }
}
