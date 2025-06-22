import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_status.dart';
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
      status: CourseStatus.inProgress,
    ),
    PurchasedCourseEntity(
      id: '2',
      title: 'Belajar Python: Dari Dasar hingga Mahir',
      thumbnail: 'https://picsum.photos/400/250?random=2',
      progress: 0.30, // 30% complete
      lastAccessed: DateTime.now().subtract(const Duration(days: 5)),
      status: CourseStatus.inProgress,
    ),
    PurchasedCourseEntity(
      id: '3',
      title: 'Advanced JavaScript Concepts',
      thumbnail: 'https://picsum.photos/400/250?random=3',
      progress: 0.0, // Not started
      lastAccessed: DateTime.now().subtract(const Duration(days: 10)),
      status: CourseStatus.notStarted,
    ),
    PurchasedCourseEntity(
      id: '4',
      title: 'Complete Web Development Bootcamp',
      thumbnail: 'https://picsum.photos/400/250?random=4',
      progress: 1.0, // 100% complete - Completed course
      lastAccessed: DateTime.now().subtract(const Duration(hours: 2)),
      status: CourseStatus.completed,
    ),
    PurchasedCourseEntity(
      id: '5',
      title: 'UI/UX Design with Figma',
      thumbnail: 'https://picsum.photos/400/250?random=5',
      progress: 1.0,
      lastAccessed: DateTime.now().subtract(const Duration(days: 20)),
      status: CourseStatus.completed,
    ),
    PurchasedCourseEntity(
      id: '6',
      title: 'Data Science with Python',
      thumbnail: 'https://picsum.photos/400/250?random=6',
      progress: 0.50,
      lastAccessed: DateTime.now().subtract(const Duration(days: 3)),
      status: CourseStatus.inProgress,
    ),
  ];

  @override
  Future<List<PurchasedCourseEntity>> getPurchasedCourses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _purchasedCourses;
  }
}
