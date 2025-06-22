import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/data/datasources/purchased_course_remote_datasource.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/domain/repositories/purchased_course_repository.dart';

@LazySingleton(as: PurchasedCourseRepository)
class PurchasedCourseRepositoryImpl implements PurchasedCourseRepository {
  final PurchasedCourseRemoteDataSource remoteDataSource;

  PurchasedCourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<PurchasedCourseEntity>>>
      getPurchasedCourses() async {
    try {
      final courses = await remoteDataSource.getPurchasedCourses();
      return Right(courses);
    } catch (e) {
      return Left('Failed to fetch purchased courses: $e');
    }
  }

  @override
  Future<Either<String, PurchasedCourseEntity>> updateCourseProgress(
    String courseId,
    int completedMaterials,
  ) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, this would update the database
      // For now, we'll return a mock updated course with increased progress
      final updatedCourse = PurchasedCourseEntity(
        id: courseId,
        title: 'Belajar Python: Dari Dasar hingga Mahir',
        thumbnail: 'https://picsum.photos/400/250?random=2',
        progress: 0.40, // Updated progress (was 0.30)
        lastAccessed: DateTime.now(),
      );

      return Right(updatedCourse);
    } catch (e) {
      return Left('Failed to update course progress: $e');
    }
  }
}
