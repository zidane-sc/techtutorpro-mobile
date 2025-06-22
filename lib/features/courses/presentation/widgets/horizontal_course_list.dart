import 'package:flutter/material.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/horizontal_course_card.dart';

class HorizontalCourseList extends StatelessWidget {
  final List<CourseEntity> courses;
  final double height;
  final double cardWidth;

  const HorizontalCourseList({
    super.key,
    required this.courses,
    this.height = 200,
    this.cardWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No courses available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return HorizontalCourseCard(
            course: course,
            width: cardWidth,
          );
        },
      ),
    );
  }
}
