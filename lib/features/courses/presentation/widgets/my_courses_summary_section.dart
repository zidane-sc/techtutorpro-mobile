import 'package:flutter/material.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_status.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/summary_stat_card.dart';

class MyCoursesSummarySection extends StatelessWidget {
  final List<PurchasedCourseEntity> courses;

  const MyCoursesSummarySection({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final total = courses.length;
    final inProgress =
        courses.where((c) => c.status == CourseStatus.inProgress).length;
    final completed =
        courses.where((c) => c.status == CourseStatus.completed).length;
    final notStarted =
        courses.where((c) => c.status == CourseStatus.notStarted).length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        SummaryStatCard(
          title: 'Enrolled',
          count: '$total',
          icon: Icons.school_outlined,
          color: Colors.blue,
        ),
        SummaryStatCard(
          title: 'In Progress',
          count: '$inProgress',
          icon: Icons.timelapse_outlined,
          color: Colors.orange,
        ),
        SummaryStatCard(
          title: 'Completed',
          count: '$completed',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        ),
        SummaryStatCard(
          title: 'Not Started',
          count: '$notStarted',
          icon: Icons.bedtime_outlined,
          color: Colors.grey,
        ),
      ],
    );
  }
}
