import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/features/courses/domain/entities/purchased_course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_event.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_state.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/course_progress_bottom_sheet.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/my_courses_summary_section.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/purchased_course_card.dart';
import 'package:techtutorpro/router/app_router.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  void initState() {
    super.initState();
    // Initial fetch of purchased courses
    context.read<PurchasedCourseBloc>().add(const FetchPurchasedCourses());
  }

  Future<void> _onRefresh() async {
    context.read<PurchasedCourseBloc>().add(const FetchPurchasedCourses());
  }

  void _showCourseProgress(BuildContext context, course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<PurchasedCourseBloc>(),
        child: CourseProgressBottomSheet(course: course),
      ),
    );
  }

  void _onCourseTapped(PurchasedCourseEntity course) {
    // ... existing code ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: BlocListener<PurchasedCourseBloc, PurchasedCourseState>(
        listener: (context, state) {
          if (state is NavigateToCourseMaterial) {
            Navigator.pop(context); // Dismiss the bottom sheet
            context.pushNamed(
              AppRoute.courseMaterial.name,
              pathParameters: {'id': state.course.id},
              extra: state.course,
            );
          } else if (state is PurchasedCourseError) {
            // Optional: show a snackbar or dialog for errors that occur
            // during course fetching for navigation, if desired.
          }
        },
        child: BlocBuilder<PurchasedCourseBloc, PurchasedCourseState>(
          builder: (context, state) {
            if (state is PurchasedCourseLoading && state.courses.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PurchasedCourseError && state.courses.isEmpty) {
              return _buildErrorState(context, state);
            }

            if (state.courses.isEmpty) {
              return _buildEmptyState(context);
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCoursesSummarySection(courses: state.courses),
                    const SizedBox(height: 24),
                    Text(
                      'All Courses',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        return PurchasedCourseCard(
                          course: course,
                          onTap: () => _showCourseProgress(context, course),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, PurchasedCourseError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 16),
            Text('Failed to load courses',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(state.message, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school_outlined, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text('No Courses Yet',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              "You haven't enrolled in any courses. Explore our catalog!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
