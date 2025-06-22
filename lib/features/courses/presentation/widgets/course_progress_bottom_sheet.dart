import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/core/widgets/primary_button.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_bloc.dart';
import 'package:techtutorpro/features/courses/domain/entities/certificate_entity.dart';
import 'package:techtutorpro/router/app_router.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_event.dart';

class CourseProgressBottomSheet extends StatelessWidget {
  final PurchasedCourseEntity course;
  const CourseProgressBottomSheet({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            course.title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.show_chart_outlined,
                  label: 'Progress',
                  value: '${(course.progress * 100).toStringAsFixed(0)}%',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  icon: Icons.access_time_outlined,
                  label: 'Last Accessed',
                  value: _formatLastAccessed(),
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[200]),
          const SizedBox(height: 16),
          const _ExpandableSection(),
          const SizedBox(height: 24),
          PrimaryButton(
            text: '▶️ Resume Learning',
            onPressed: () {
              context
                  .read<PurchasedCourseBloc>()
                  .add(GetCourseForNavigation(course.id));
            },
          ),
          const SizedBox(height: 12),
          if (course.progress == 1.0)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('View Certificate'),
                onPressed: () {
                  final certificate = CertificateEntity(
                    courseTitle: course.title,
                    userName: 'Jane Doe', // Mock user name
                    completionDate: DateTime.now(), // Mock completion date
                    certificateId:
                        'TTP-${course.id}-${DateTime.now().millisecondsSinceEpoch}',
                  );

                  Navigator.pop(context); // Dismiss bottom sheet
                  context.pushNamed(
                    AppRoute.certificate.name,
                    pathParameters: {'id': course.id},
                    extra: certificate,
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }

  String _formatLastAccessed() {
    final now = DateTime.now();
    final difference = now.difference(course.lastAccessed);
    if (difference.inDays < 1) return 'Today';
    if (difference.inDays < 2) return 'Yesterday';
    return '${difference.inDays} days ago';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableSection extends StatelessWidget {
  const _ExpandableSection();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          'More Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        children: const [
          _DetailRow(
              icon: Icons.list_alt_outlined,
              label: 'Total Materials',
              value: '48'),
          SizedBox(height: 12),
          _DetailRow(
              icon: Icons.hourglass_bottom_outlined,
              label: 'Est. Remaining',
              value: '12h 30m'),
          SizedBox(height: 12),
          _DetailRow(
              icon: Icons.category_outlined,
              label: 'Category',
              value: 'Programming'),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Text(label, style: GoogleFonts.poppins()),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
