import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/router/app_router.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          context.push('/dashboard/course/${course.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLevelAndRating(),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  _buildCourseStats(context),
                  const SizedBox(height: 8),
                  _buildTags(),
                  const SizedBox(height: 12),
                  _buildPrice(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: course.thumbnail,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey.shade300,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.school_outlined, color: Colors.white, size: 50),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelAndRating() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            course.level,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text('${course.rating} (${course.reviewCount})',
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildCourseStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(
            context, Icons.people_outline, '${course.studentCount} Siswa'),
        _buildStatItem(
            context, Icons.list_alt_outlined, '${course.materialCount} Materi'),
        _buildStatItem(context, Icons.schedule_outlined,
            '${course.durationInMinutes} Menit'),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade700),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: course.tags.map((tag) {
        return Chip(
          label: Text(tag),
          backgroundColor: Colors.grey.shade200,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          labelPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 10),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }

  Widget _buildPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (course.discountedPrice != null &&
            course.discountedPrice! < course.price)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                  .format(course.price),
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ),
        Text(
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
              .format(course.discountedPrice ?? course.price),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}
