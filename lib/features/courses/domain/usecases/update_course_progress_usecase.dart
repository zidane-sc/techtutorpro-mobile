import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/domain/repositories/purchased_course_repository.dart';

@injectable
class UpdateCourseProgressUseCase {
  final PurchasedCourseRepository repository;

  UpdateCourseProgressUseCase(this.repository);

  Future<Either<String, PurchasedCourseEntity>> call(
    String courseId,
    int completedMaterials,
  ) {
    return repository.updateCourseProgress(courseId, completedMaterials);
  }
}
