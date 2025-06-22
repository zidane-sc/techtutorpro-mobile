import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/domain/repositories/purchased_course_repository.dart';

@injectable
class GetPurchasedCoursesUseCase {
  final PurchasedCourseRepository repository;

  GetPurchasedCoursesUseCase(this.repository);

  Future<Either<String, List<PurchasedCourseEntity>>> call() {
    return repository.getPurchasedCourses();
  }
}
