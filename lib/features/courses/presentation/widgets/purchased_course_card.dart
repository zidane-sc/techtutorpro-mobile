import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_status.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';

class PurchasedCourseCard extends StatelessWidget {
  final PurchasedCourseEntity course;
  final VoidCallback? onTap;

  const PurchasedCourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Thumbnail
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: course.thumbnail,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.school_outlined, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    _StatusChip(status: course.status),
                    const SizedBox(height: 12),
                    _buildProgressSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(course.progress * 100).toStringAsFixed(0)}% Completed',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearPercentIndicator(
          percent: course.progress,
          lineHeight: 8,
          barRadius: const Radius.circular(4),
          backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
          progressColor: _getStatusColor(course.status),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 8),
        Text(
          'Last accessed: ${_formatLastAccessed()}',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: isDark ? Colors.grey[500] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatLastAccessed() {
    final now = DateTime.now();
    final difference = now.difference(course.lastAccessed);

    if (difference.inDays < 1) return 'Today';
    if (difference.inDays < 2) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    }
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  }

  Color _getStatusColor(CourseStatus status) {
    switch (status) {
      case CourseStatus.completed:
        return Colors.green;
      case CourseStatus.inProgress:
        return Colors.blue;
      case CourseStatus.notStarted:
        return Colors.grey;
    }
  }
}

class _StatusChip extends StatelessWidget {
  final CourseStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getText(),
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getColor(),
        ),
      ),
    );
  }

  String _getText() {
    switch (status) {
      case CourseStatus.completed:
        return 'Completed';
      case CourseStatus.inProgress:
        return 'In Progress';
      case CourseStatus.notStarted:
        return 'Not Started';
    }
  }

  Color _getColor() {
    switch (status) {
      case CourseStatus.completed:
        return Colors.green;
      case CourseStatus.inProgress:
        return Colors.blue;
      case CourseStatus.notStarted:
        return Colors.grey;
    }
  }
}
