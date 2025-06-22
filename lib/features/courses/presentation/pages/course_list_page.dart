import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/course_card.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/filter_panel.dart';
import 'package:techtutorpro/injection.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(FetchCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              final courseBloc = context.read<CourseBloc>();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => FilterPanel(
                  courseBloc: courseBloc,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading || state is CourseInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CourseError) {
            return Center(child: Text(state.message));
          }
          if (state is CourseLoaded) {
            return _buildCourseList(state.courses);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCourseList(List<CourseEntity> courses) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CourseCard(course: course),
        );
      },
    );
  }
}
