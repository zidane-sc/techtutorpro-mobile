import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/purchased_course_card.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchasedCourseBloc>().add(FetchPurchasedCourses());
    });
  }

  Future<void> _refreshCourses() async {
    context.read<PurchasedCourseBloc>().add(FetchPurchasedCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        centerTitle: true,
      ),
      body: BlocBuilder<PurchasedCourseBloc, PurchasedCourseState>(
        builder: (context, state) {
          final bool isLoading = state is PurchasedCourseLoading;
          final bool hasError = state is PurchasedCourseError;
          final bool isEmpty = state.courses.isEmpty;

          // Initial loading state
          if (isLoading && isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (hasError && isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text('Failed to load courses',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    if (state is PurchasedCourseError)
                      Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _refreshCourses,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Empty state
          if (isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.school_outlined,
                        size: 60, color: Colors.grey),
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

          // Content with pull-to-refresh
          return RefreshIndicator(
            onRefresh: _refreshCourses,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return PurchasedCourseCard(course: course);
              },
            ),
          );
        },
      ),
    );
  }
}
