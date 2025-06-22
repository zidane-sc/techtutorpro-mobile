import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/core/theme/app_theme.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_material_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/material_content_widget.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/material_sidebar_widget.dart';

/// CourseMaterialPage - A modern and reusable course material learning interface
///
/// Features:
/// - Left sidebar with expandable material categories (accordion style)
/// - Right content area displaying text or video materials
/// - Navigation between materials with "I'm Understand" button
/// - Progress tracking and completion feedback
/// - Modern UI with gradients, shadows, and rounded corners
///
/// Architecture:
/// - Uses BLoC pattern for state management
/// - Clean separation of concerns with dedicated widgets
/// - Follows Material 3 design principles
/// - Supports both text and video content types
class CourseMaterialPage extends StatelessWidget {
  final CourseEntity course;

  const CourseMaterialPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseMaterialBloc()..add(LoadCourseMaterial(course)),
      child: const CourseMaterialView(),
    );
  }
}

/// Main view component that handles the layout and state management
class CourseMaterialView extends StatelessWidget {
  const CourseMaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseMaterialBloc, CourseMaterialState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('An error occurred: ${state.error}')),
          );
        }

        if (state.course == null) {
          return const Scaffold(
            body: Center(child: Text('Course data is not available.')),
          );
        }

        final courseTitle = state.course!.title;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              courseTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Back to course details',
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: MaterialSidebarWidget(
              course: state.course!,
              currentMaterial: state.currentMaterial,
              sectionStates: state.sectionStates,
            ),
          ),
          body: MaterialContentWidget(
            course: state.course!,
            currentMaterial: state.currentMaterial,
            isLastMaterial: state.isLastMaterial,
          ),
        );
      },
    );
  }
}
