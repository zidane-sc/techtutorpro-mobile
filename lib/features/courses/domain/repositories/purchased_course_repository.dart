import 'package:dartz/dartz.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';

abstract class PurchasedCourseRepository {
  Future<Either<String, List<PurchasedCourseEntity>>> getPurchasedCourses();
  Future<Either<String, PurchasedCourseEntity>> updateCourseProgress(
    String courseId,
    int completedMaterials,
  );
}
