import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/core/widgets/primary_button.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_review_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_detail/course_detail_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_bloc.dart';
import 'package:techtutorpro/injection.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CourseDetailBloc>()
            ..add(FetchCourseDetail(courseId: courseId)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<PurchasedCourseBloc>()..add(FetchPurchasedCourses()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
            if (state is CourseDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CourseDetailLoaded) {
              return CourseDetailView(course: state.course);
            } else if (state is CourseDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({super.key, required this.course});
  final CourseEntity course;

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  bool isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    // bool isPurchased =
    //     context.select((CourseDetailBloc bloc) => bloc.state.isPurchased);
    const bool isPurchased = false; // FIXME: Get from somewhere else
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          stretch: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.course.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            stretchModes: const [StretchMode.zoomBackground],
            background: CachedNetworkImage(
              imageUrl: widget.course.thumbnail,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCourseMeta(context, course: widget.course),
                const SizedBox(height: 24),
                _buildEnrollButton(context, course: widget.course),
                const SizedBox(height: 24),
                _buildDescription(context,
                    description: widget.course.description),
                const SizedBox(height: 24),
                Text(
                  "Materi Kursus",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        if (widget.course.materialSections.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildCourseMaterials(
                  sections: widget.course.materialSections),
            ),
          )
        else
          const SliverToBoxAdapter(
              child: Center(child: Text("Tidak ada materi tersedia"))),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Ulasan (${widget.course.reviewCount})",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (widget.course.reviews.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildReviews(reviews: widget.course.reviews),
            ),
          )
        else
          const SliverToBoxAdapter(
              child: Center(child: Text("Belum ada ulasan"))),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildCourseMeta(BuildContext context,
      {required CourseEntity course}) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        _buildMetadataItem(context, Icons.bar_chart, course.level),
        _buildMetadataItem(context, Icons.people_alt_outlined,
            '${course.studentCount} students'),
        _buildMetadataItem(context, Icons.star_border,
            '${course.rating} (${course.reviewCount} reviews)'),
        _buildMetadataItem(context, Icons.videocam_outlined, course.method),
        _buildMetadataItem(context, Icons.schedule,
            '${(course.durationInMinutes / 60).toStringAsFixed(1)} hours'),
        _buildMetadataItem(
            context, Icons.list_alt, '${course.materialCount} materials'),
      ],
    );
  }

  Widget _buildMetadataItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildDescription(BuildContext context,
      {required String description}) {
    // Simple check if text needs expansion (if it's longer than ~150 characters)
    final needsExpansion = description.length > 150;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: isDescriptionExpanded ? null : 3,
          overflow: isDescriptionExpanded ? null : TextOverflow.ellipsis,
        ),
        if (needsExpansion) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                isDescriptionExpanded = !isDescriptionExpanded;
              });
            },
            child: Text(
              isDescriptionExpanded ? "Show Less" : "Show More",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCourseMaterials(
      {required List<CourseMaterialSectionEntity> sections}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: sections.map((section) {
          return ExpansionTile(
            title: Text(section.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            children: section.materials.map((material) {
              return ListTile(
                leading: Icon(_getMaterialIcon(material.type), size: 20),
                title: Text(material.title),
                dense: true,
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  IconData _getMaterialIcon(CourseMaterialType type) {
    switch (type) {
      case CourseMaterialType.video:
        return Icons.play_circle_outline;
      case CourseMaterialType.text:
        return Icons.article_outlined;
    }
  }

  Widget _buildReviews({required List<CourseReviewEntity> reviews}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: reviews.map((review) => _buildReviewItem(review)).toList(),
        ),
      ),
    );
  }

  Widget _buildReviewItem(CourseReviewEntity review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(review.studentName.substring(0, 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(review.studentName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    _buildRatingStars(review.rating),
                  ],
                ),
                const SizedBox(height: 4),
                Text(review.review),
                const SizedBox(height: 4),
                Text(
                  DateFormat('d MMMM yyyy').format(review.date),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  Widget _buildEnrollButton(BuildContext context,
      {required CourseEntity course}) {
    return BlocBuilder<PurchasedCourseBloc, PurchasedCourseState>(
      builder: (context, purchasedState) {
        // Check if course is purchased
        bool isPurchased = false;
        if (purchasedState is PurchasedCourseLoaded) {
          isPurchased = purchasedState.courses
              .any((purchasedCourse) => purchasedCourse.id == course.id);
        }

        // If purchased, show Learn button
        if (isPurchased) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.05),
                  blurRadius: 20.0,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Course Purchased',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // Navigate to course material page
                    context.pushNamed(
                      'courseMaterial',
                      pathParameters: {'id': course.id},
                      extra: course,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.green.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_circle_outline,
                            color: Colors.white),
                        const SizedBox(width: 12),
                        Text(
                          'Learn',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // If not purchased, show original enroll button
        final price = course.discountedPrice ?? course.price;
        final hasDiscount = course.discountedPrice != null;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.05),
                blurRadius: 20.0,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(price),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(course.price),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  if (hasDiscount)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDDE1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '${(((course.price - course.discountedPrice!) / course.price) * 100).round()}% OFF',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  context.pushNamed('paymentSummary', extra: course);
                },
                child: Container(
                  width: double.infinity,
                  height: 52.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        const Color(0xFF7F9CF5)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.school_outlined, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        'Enroll Course',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
