import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';

abstract class PurchasedCourseRemoteDataSource {
  Future<List<PurchasedCourseEntity>> getPurchasedCourses();
}

@LazySingleton(as: PurchasedCourseRemoteDataSource)
class PurchasedCourseRemoteDataSourceImpl
    implements PurchasedCourseRemoteDataSource {
  // Mock data for purchased courses
  final List<PurchasedCourseEntity> _purchasedCourses = [
    PurchasedCourseEntity(
      id: '1',
      title: 'Flutter for Beginners: From Zero to Hero',
      thumbnail: 'https://picsum.photos/400/250?random=1',
      progress: 0.75, // 75% complete
      lastAccessed: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PurchasedCourseEntity(
      id: '2',
      title: 'Belajar Python: Dari Dasar hingga Mahir',
      thumbnail: 'https://picsum.photos/400/250?random=2',
      progress: 0.30, // 30% complete
      lastAccessed: DateTime.now().subtract(const Duration(days: 5)),
    ),
    PurchasedCourseEntity(
      id: '3',
      title: 'Advanced JavaScript Concepts',
      thumbnail: 'https://picsum.photos/400/250?random=3',
      progress: 0.0, // Not started
      lastAccessed: DateTime.now().subtract(const Duration(days: 10)),
    ),
    PurchasedCourseEntity(
      id: '4',
      title: 'Complete Web Development Bootcamp',
      thumbnail: 'https://picsum.photos/400/250?random=4',
      progress: 1.0, // 100% complete - Completed course
      lastAccessed: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  Future<List<PurchasedCourseEntity>> getPurchasedCourses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _purchasedCourses;
  }
}
